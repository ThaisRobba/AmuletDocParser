
API reference
=============

## Window functions

### am.window(settings) {#window_func .func-def}

Creates a new window, returning a window object. `settings` is a
table with any of the following fields:

- **`mode`**:
    Either `"windowed"` or `"fullscreen"`. A fullscreen window will
    have the same resolution as the user's desktop. The default is
    `"windowed"`. Not all platforms support windowed mode (e.g. iOS).
    On these platforms this setting is ignored.

- **`width` and `height`**:
    The desired size of the window. This is not necessarily the size
    of the window in pixels (although it usually is if the window
    is created in `"windowed"` mode). Instead it defines the size of the window's
    *default coordinate system*. If letterboxing is enabled then this
    is (`-width/2`, `-height/2`) in the bottom-left corner and
    (`width/2`, `height/2`) in the top-right corner.
    If letterboxing is disabled, then the
    coordinate system will extend in the horizontal or vertical
    directions to ensure an area of at least `width`×`height` is
    visible in the center of the window. In either case the centre
    coordinate will always be (0, 0).
    The default size is 640×480.

- **`title`**:
    The window title.

- **`resizable`**:
    Whether the window can be resized by the user (`true` or `false`,
    default `true`).

- **`borderless`**:
    Whether the window has a title bar and border (`true` or `false`,
    default `false`).

- **`depth_buffer`**:
    Whether the window has a depth buffer (`true` or `false`,
    default `false`).

- **`stencil_buffer`**:
    Whether the window has a stencil buffer (`true` or `false`,
    default `false`).

- **`lock_pointer`**:
    `true` or `false`. When pointer lock is enabled the cursor will be
    hidden and mouse movement will be set to "relative" mode. In this
    mode the mouse is tracked infinitely in all directions, i.e. as if
    there is no edge of the screen to stop the mouse cursor. This is
    useful for implementing first-person style mouse-look. The default
    is `false`.

- **`clear_color`**:
    The color (a `vec4`) used to clear the window each frame before drawing.
    The default clear color is black (`vec4(0, 0, 0, 1)`).

- **`letterbox`**:
    `true` or `false`. Indicates whether the original aspect ratio (as
    determined by the `width` and `height` settings of the window)
    should be maintained after a resize by adding black horizontal or
    vertical bars to the sides of the window. The default is `true`.

- **`msaa_samples`**:
    The number of samples to use for multisample anti-aliasing. This
    must be a power of 2. Use zero (the default) for no anti-aliasing.

- **`orientation`**:
    `"portrait"` or `"landscape"`. This specifies the supported
    orientation of the window on platforms that support orientation
    changes (e.g. iOS). If omitted, both orientations are supported.

- **`projection`**:
    A custom projection matrix (a `mat4`) to be used for the window's
    coordinate system. This matrix is used when transforming
    mouse or touch event coordinates and is set as the projection
    matrix for rendering, but does not affect the `left`, `right`,
    `top`, `bottom`, `width` and `height` fields of the window.

## Window fields

### window.left {.func-def}

The x coordinate of the left edge of the 
window in the window's default coordinate system.

Readonly.

### window.right {.func-def}

The x coordinate of the right edge of the window, in the window's
default coordinate system.

Readonly.

### window.bottom {.func-def}

The y coordinate of the bottom edge of the window, in the window's
default coordinate system.

Readonly.

### window.top {.func-def}

The y coordinate of the top edge of the window, in the window's
default coordinate system.

Readonly.

### window.width {.func-def}

The width of the window in the window's default coordinate system.
This will always be equal to the `width` setting supplied
when the window was created if the `letterbox` setting is
enabled. Otherwise it may be larger, but it will never be
smaller than the `width` setting.

Readonly.

### window.height {.func-def}

The height of the window in the window's default coordinate space.
This will always be equal to the `height` setting supplied
when the window was created if the `letterbox` setting is
enabled. Otherwise it may be larger, but it will never be
smaller than the `height` setting.

Readonly.

### window.pixel_width {.func-def}

The real width of the window in pixels.

Readonly.

### window.pixel_height {.func-def}

The real height of the window in pixels

Readonly.

### window.mode {.func-def}

See [window settings](#window_func).

Updatable.

### window.clear_color {.func-def}

See [window settings](#window_func).

Updatable.

### window.letterbox {.func-def}

See [window settings](#window_func).

Updatable.

### window.lock_pointer {.func-def}

See [window settings](#window_func).

Updatable.

### window.scene {.func-def}

The scene node currently attached to the window.
This scene will be rendered to the window each frame.

Updatable.

### window.projection {.func-def}

See [window settings](#window_func).

Updatable.

## Window methods

### window:close() {.func-def}

Closes the window and quits the application if this was
the only window.

### window:key_down(key) {#key_down .func-def}

Returns true if the given key was down at the start of the
current frame.

The possible values for `key` are:

- `"a"`
- `"b"`
- `"c"`
- `"d"`
- `"e"`
- `"f"`
- `"g"`
- `"h"`
- `"i"`
- `"j"`
- `"k"`
- `"l"`
- `"m"`
- `"n"`
- `"o"`
- `"p"`
- `"q"`
- `"r"`
- `"s"`
- `"t"`
- `"u"`
- `"v"`
- `"w"`
- `"x"`
- `"y"`
- `"z"`
- `"1"`
- `"2"`
- `"3"`
- `"4"`
- `"5"`
- `"6"`
- `"7"`
- `"8"`
- `"9"`
- `"0"`
- `"enter"`
- `"escape"`
- `"backspace"`
- `"tab"`
- `"space"`
- `"minus"`
- `"equals"`
- `"leftbracket"`
- `"rightbracket"`
- `"backslash"`
- `"semicolon"`
- `"quote"`
- `"backquote"`
- `"comma"`
- `"period"`
- `"slash"`
- `"capslock"`
- `"f1"`
- `"f2"`
- `"f3"`
- `"f4"`
- `"f5"`
- `"f6"`
- `"f7"`
- `"f8"`
- `"f9"`
- `"f10"`
- `"f11"`
- `"f12"`
- `"printscreen"`
- `"scrolllock"`
- `"pause"`
- `"insert"`
- `"home"`
- `"pageup"`
- `"delete"`
- `"end"`
- `"pagedown"`
- `"right"`
- `"left"`
- `"down"`
- `"up"`
- `"kp_divide"`
- `"kp_multiply"`
- `"kp_minus"`
- `"kp_plus"`
- `"kp_enter"`
- `"kp_1"`
- `"kp_2"`
- `"kp_3"`
- `"kp_4"`
- `"kp_5"`
- `"kp_6"`
- `"kp_7"`
- `"kp_8"`
- `"kp_9"`
- `"kp_0"`
- `"kp_period"`
- `"lctrl"`
- `"lshift"`
- `"lalt"`
- `"lgui"`
- `"rctrl"`
- `"rshift"`
- `"ralt"`
- `"rgui"`

### window:keys_down() {.func-def}

Returns an array of the keys that were down at the
start of the current frame.
See [window:key_down](#key_down) for a list of possible
key values.

### window:key_pressed(key) {.func-def}

Returns true if the given key's state changed from up
to down since the last frame.
See [window:key_down](#key_down) for possible values
for `key`.

Note that if `key_pressed` returns true, then
`key_down` will also return `true`. Also if `key_pressed`
returns `true` then `key_released` will always return `false`.
(If necessary, Amulet will postpone key release events to the
next frame to ensure this.)

### window:key_released(key) {.func-def}

Returns true if the given key's state changed from down
to up since the last frame.
See [window:key_down](#key_down) for possible values
for `key`.

Note that if `key_released` returns true, then
`key_down` will also return `false`. Also if `key_released`
returns `true` then `key_pressed` will always return `false`.
(If necessary, Amulet will postpone key press events to the
next frame to ensure this.)

### window:mouse_position() {.func-def}

Returns the position of the mouse cursor, as a `vec2`,
in the window's coordinate system.

### window:mouse_norm_position() {.func-def}

Returns the position of the mouse cursor in normalized device coordinates,
as a `vec2`.

### window:mouse_pixel_position() {.func-def}

Returns the position of the mouse cursor in pixels where the bottom left
corner of the window has coordinate (0, 0), as a `vec2`.

### window:mouse_delta() {.func-def}

Returns the change in mouse position since the last frame, in
the window's coordinate system (a `vec2`).

### window:mouse_norm_delta() {.func-def}

Returns the change in mouse position since the last frame, in
normalized device coordinates (a `vec2`).

### window:mouse_pixel_delta() {.func-def}

Returns the change in mouse position since the last frame, in
pixels (a `vec2`).

### window:mouse_down(button) {.func-def}

Returns `true` if the given button was down
at the start of the frame. `button` may be `"left"`,
`"right"` or `"middle"`.

### window:mouse_pressed(button) {.func-def}

Returns `true` if the given mouse button's state changed
from up to down since the
last frame.
`button` may be `"left"`, `"right"` or `"middle"`.

Note that if `mouse_pressed` returns `true` then
`mouse_down` will also return `true`. Also 
if `mouse_pressed` returns `true` then `mouse_released`
will always return `false`. (If necessary, Amulet will
postpone button release events to the next frame to ensure this.)

### window:mouse_released(button) {.func-def}

Returns true if the given mouse button's state changed
from down to up since the last frame.
`button` may be `"left"`, `"right"` or `"middle"`.

Note that if `mouse_released` returns `true` then
`mouse_down` will also return `false`. Also 
if `mouse_released` returns `true` then `mouse_pressed`
will always return `false`. (If necessary, Amulet will
postpone button press events to the next frame to ensure this.)

### window:mouse_wheel() {.func-def}

Returns the mouse scroll wheel position (a `vec2`).

### window:mouse_wheel_delta() {.func-def}

Returns the change in mouse scroll wheel position since the
last frame (a `vec2`).

### window:touches_began() {.func-def #touches_began}

Returns an array of the touches that began since the last frame.

Each touch is an integer and each time a new touch
occurs the lowest available integer greater than or equal to 1 is assigned to
the touch.

If there are no other active touches then the next touch
will always be 1, so if your interface only expects a single
touch at a time, you can just use 1 for all touch functions
that take a touch argument and any additional touches will be
ignored.

### window:touches_ended() {.func-def}

Returns an array of the touches that ended since the last frame.

### window:active_touches() {.func-def}

Returns an array of the currently active touches.

### window:touch_began(touch) {.func-def}

Returns true if the specific touch began since the last frame.

See [`window:touches_began`](#touches_began) for additional
notes on the `touch` argument.

### window:touch_ended(touch) {.func-def}

Returns true if the specific touch ended since the last frame.

See [`window:touches_began`](#touches_began) for additional
notes on the `touch` argument.

### window:touch_position(touch) {.func-def}

Returns the last touch position in the window's coordinate system
(a `vec2`).

See [`window:touches_began`](#touches_began) for additional
notes on the `touch` argument.

### window:touch_norm_position(touch) {.func-def}

Returns the last touch position in normalized device coordinates
(a `vec2`).

See [`window:touches_began`](#touches_began) for additional
notes on the `touch` argument.

### window:touch_pixel_position(touch) {.func-def}

Returns the last touch position in pixels, where the bottom left
corner of the window is (0, 0) (a `vec2`).

See [`window:touches_began`](#touches_began) for additional
notes on the `touch` argument.

### window:touch_delta(touch) {.func-def}

Returns the change in touch position since the
last frame in the window's coordinate system (a `vec2`).

See [`window:touches_began`](#touches_began) for additional
notes on the `touch` argument.

### window:touch_norm_delta(touch) {.func-def}

Returns the change in touch position since the
last frame in normalized device coordinates (a `vec2`).

See [`window:touches_began`](#touches_began) for additional
notes on the `touch` argument.

### window:touch_pixel_delta(touch) {.func-def}

Returns the change in touch position since the
last frame in pixels (a `vec2`).

See [`window:touches_began`](#touches_began) for additional
notes on the `touch` argument.

### window:resized() {.func-def}

Returns true if the window's size changed since the last frame.
