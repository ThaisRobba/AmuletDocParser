Builds a .luacompleterc and a .luacheckrc by using Amulet (must be in PATH).

It is *very* quick and dirty but in editors that allow it, it provides some level of autocompletion for types, like so:

Basic completion:

![](basic.png)

Type based completion:

![](node.png)

Assumptions:
- User project source is within a `src` folder
- User has a `window` global which gives access to an am.window instance

Missing:
- Swizzle fields (probably only doable in a sane way with a custom provider)
- mat2, mat3 and mat4 returnType
- quat returnType
- quad returnType
- differentiating between globals and read_only
