## Names and default bindings of the game's input actions.
## Every action works on both keyboard and gamepad (Story 001,
## .claude/docs/technical-preferences.md: gamepad primary, keyboard supported).
class_name InputActions
extends RefCounted

const MOVE_LEFT: StringName = &"move_left"
const MOVE_RIGHT: StringName = &"move_right"
const AIM_UP: StringName = &"aim_up"
const JUMP: StringName = &"jump"
const SHOOT: StringName = &"shoot"

const _STICK_DEADZONE: float = 0.3


## Registers the default bindings in the InputMap. Actions that already exist
## (for example, defined in Project Settings) are left untouched. Safe to call
## more than once.
static func ensure_defaults() -> void:
	_add(MOVE_LEFT, [
		_key(KEY_A), _key(KEY_LEFT),
		_joy_button(JOY_BUTTON_DPAD_LEFT), _joy_axis(JOY_AXIS_LEFT_X, -1.0),
	])
	_add(MOVE_RIGHT, [
		_key(KEY_D), _key(KEY_RIGHT),
		_joy_button(JOY_BUTTON_DPAD_RIGHT), _joy_axis(JOY_AXIS_LEFT_X, 1.0),
	])
	_add(AIM_UP, [
		_key(KEY_W), _key(KEY_UP),
		_joy_button(JOY_BUTTON_DPAD_UP), _joy_axis(JOY_AXIS_LEFT_Y, -1.0),
	])
	_add(JUMP, [_key(KEY_SPACE), _key(KEY_Z), _joy_button(JOY_BUTTON_A)])
	_add(SHOOT, [_key(KEY_J), _key(KEY_X), _joy_button(JOY_BUTTON_X)])


static func _add(action: StringName, events: Array[InputEvent]) -> void:
	if InputMap.has_action(action):
		return
	InputMap.add_action(action, _STICK_DEADZONE)
	for event: InputEvent in events:
		InputMap.action_add_event(action, event)


static func _key(code: Key) -> InputEventKey:
	var event := InputEventKey.new()
	event.physical_keycode = code
	return event


static func _joy_button(button: JoyButton) -> InputEventJoypadButton:
	var event := InputEventJoypadButton.new()
	event.button_index = button
	return event


static func _joy_axis(axis: JoyAxis, direction: float) -> InputEventJoypadMotion:
	var event := InputEventJoypadMotion.new()
	event.axis = axis
	event.axis_value = direction
	return event
