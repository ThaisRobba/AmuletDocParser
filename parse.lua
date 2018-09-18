local chars = "[%w_]"

local function get_name(str)
    local method = str:match("%a%.(" .. chars .. "+)%(") or str:match("%a:(" .. chars .. "+)%(")
    local property = str:match("%a%.(" .. chars .. "+) ")
    local global_func = str:match(" (.-)%(")

    if method then
        return method
    elseif property then
        return property
    else
        return global_func
    end
end

local function get_type(str)
    local method = str:match("%a%.(" .. chars .. "+)%(") or str:match("%a:(" .. chars .. "+)%(")
    local global_func = str:match(" (.-)%(")

    if method or global_func then
        return "function"
    else
        return "other"
    end
end

local function get_namespace(str)
    return str:match(" (" .. chars .. "+)%.%a") or str:match(" (" .. chars .. "+):%a")
end

local function get_description(str, i)
    i = i + 2
    local line = str[i]
    local description
    while line and not line:find("#") do
        local whitespace = ""

        if line:find("~~~") then
            line = line:gsub("~~~", "\n```\n")
            line = line:gsub("{.lua}", "")
            whitespace = ""
        elseif line:find("-") or line:find("\r\n") then
            whitespace = "\n"
        end

        if description then
            description = description .. whitespace .. line
        else
            description = line
        end
        i = i + 1
        line = str[i]
    end

    return description, i
end

local function get_params(str)
    local params_str = str:match("%((.-)%)")
    local has_self = str:find(":")
    local args

    if has_self then
        args = {
            {
                name = "self"
            }
        }
    end

    if params_str and params_str:find(",") then
        local clean_str = params_str:gsub("%[", ""):gsub("%]", ""):gsub("%,", "")
        args = args or {}
        for param in clean_str:gmatch("%S+") do
            table.insert(args, {name = param})
        end
    elseif params_str then
        args = args or {}
        table.insert(args, {name = params_str})
    end

    local argsDisplay = params_str
    if has_self then
        if params_str and params_str ~= "" then
            argsDisplay = "self, " .. argsDisplay
        else
            argsDisplay = "self"
        end
    end

    return args, argsDisplay, params_str
end

--------------------

local global = {
    type = "table",
    fields = {
        am = {
            type = "table",
            fields = {}
        },
        math = {
            type = "table",
            fields = {}
        },
        table = {
            type = "table",
            fields = {}
        },
        vec2 = {
            type = "function",
            args = {
                {
                    name = "x"
                },
                {
                    name = "y"
                }
            },
            returnTypes = {
                {
                    type = "ref",
                    name = "vec2"
                }
            }
        },
        vec3 = {
            type = "function",
            args = {
                {
                    name = "x"
                },
                {
                    name = "y"
                },
                {
                    name = "z"
                }
            },
            returnTypes = {
                {
                    type = "ref",
                    name = "vec3"
                }
            }
        },
        vec4 = {
            type = "function",
            args = {
                {
                    name = "x"
                },
                {
                    name = "y"
                },
                {
                    name = "z"
                },
                {
                    name = "w"
                }
            },
            returnTypes = {
                {
                    type = "ref",
                    name = "vec4"
                }
            }
        },
        mat2 = {
            type = "function"
        },
        mat3 = {
            type = "function"
        },
        mat4 = {
            type = "function"
        },
        quat = {
            type = "function"
        }
    }
}

local namedTypes = {
    vec2 = {
        type = "table",
        fields = {
            x = {
                type = "number"
            },
            y = {
                type = "number"
            },
            r = {
                type = "number"
            },
            g = {
                type = "number"
            },
            s = {
                type = "number"
            },
            t = {
                type = "number"
            }
        }
    },
    vec3 = {
        type = "table",
        fields = {
            x = {
                type = "number"
            },
            y = {
                type = "number"
            },
            z = {
                type = "number"
            },
            r = {
                type = "number"
            },
            g = {
                type = "number"
            },
            b = {
                type = "number"
            },
            s = {
                type = "number"
            },
            t = {
                type = "number"
            },
            p = {
                type = "number"
            }
        }
    },
    vec4 = {
        type = "table",
        fields = {
            x = {
                type = "number"
            },
            y = {
                type = "number"
            },
            z = {
                type = "number"
            },
            w = {
                type = "number"
            },
            r = {
                type = "number"
            },
            g = {
                type = "number"
            },
            b = {
                type = "number"
            },
            a = {
                type = "number"
            },
            s = {
                type = "number"
            },
            t = {
                type = "number"
            },
            p = {
                type = "number"
            },
            q = {
                type = "number"
            }
        }
    }
}

local output = {
    luaVersion = "5.1",
    global = global,
    packagePath = "./?.lua,./?/init.lua",
    namedTypes = namedTypes,
    cwd = "./src"
}

---------------

local function parse(str, returnTypes)
    for i = 1, #str do
        local line = str[i]

        if line:match("(%-)def") then
            local namespace = get_namespace(line)

            local description = get_description(str, i)

            local name = get_name(line)
            local typeof = get_type(line)

            local args, argsDisplay, argsDisplayOmitSelf

            if typeof == "function" then
                args, argsDisplay, argsDisplayOmitSelf = get_params(line)
            end

            local target
            if namespace then
                if global.fields[namespace] then
                    target = global.fields[namespace].fields
                else
                    namedTypes[namespace] =
                        namedTypes[namespace] or
                        {
                            type = "table",
                            fields = {}
                        }

                    target = namedTypes[namespace].fields
                end
            else
                -- Since nodes are callable tables, they kinda break this last case.
                -- Dirty fix, avoids adding them to the global table.
                if name ~= "node" then
                    target = global.fields
                end
            end

            if target and name then
                target[name] = {
                    type = typeof,
                    description = description,
                    args = args,
                    argsDisplay = argsDisplay,
                    argsDisplayOmitSelf = argsDisplayOmitSelf,
                    returnTypes = returnTypes
                }
            end
        end
    end
end

local function read_lines(file)
    local f = io.open(file)
    local lines = {}
    local i = 1
    for line in f:lines() do
        lines[i] = line
        i = i + 1
    end
    f:close()
    return lines
end

-------------

local function write_luacompleterc(str)
    local f = io.open(".luacompleterc", "w")
    f:write(str)
    f:close()
end

-------------

local exceptions = {
    ["doc/scene_nodes.md"] = {
        {
            type = "ref",
            name = "node"
        }
    }
}

local files = am.glob({"doc/*.md"})
for _, file in pairs(files) do
    print("Parsing...", file)
    local lines = read_lines(file)
    parse(lines, exceptions[file])
end

local completerc_json_str = am.to_json(output)
write_luacompleterc(completerc_json_str)

---------------

local function parse_for_luacheck(t)
    local formatted = {}

    for k, v in pairs(t.fields) do
        if v.type == "table" then
            formatted[k] = {
                fields = parse_for_luacheck(v)
            }
        else
            table.insert(formatted, k)
        end
    end

    return formatted
end

local conf_global =
    [[
files["src/conf.lua"] = {
    globals = {
        "title",
        "shortname",
        "author",
        "appid",
        "version",
        "support_email",
        "display_name",
        "dev_region",
        "supported_languages",
        "icon",
        "launch_image",
        "orientation"
    }
}]]

local window_global =
    [[
globals = {
    window = {
        fields = {
            "left",
            "right",
            "bottom",
            "top",
            "width",
            "height",
            "pixel_width",
            "pixel_height",
            "mode",
            "clear_color",
            "stencil_clear_value",
            "letterbox",
            "lock_pointer",
            "show_cursor",
            "scene",
            "projection",
        }
    }
}
]]

local function write_luacheckrc()
    local f = io.open(".luacheckrc", "w")
    f:write("std = 'lua51'\n")
    f:write("self = true\n")
    f:write(window_global .. "\n")
    f:write("read_globals = " .. table.tostring(parse_for_luacheck(global)) .. "\n")
    f:write(conf_global)
    f:close()
end

write_luacheckrc()
