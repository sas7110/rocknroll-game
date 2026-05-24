extends Node

# Registers game-specific input actions for player 1 (and later player 2).
# Mirrors the default mapping documented in docs/PLAN_v2.md §4.2.
#
# Per-action config keys:
#   keys    — physical_keycode list (KEY_*)
#   buttons — JoypadButton list (JOY_BUTTON_*)
#   axis    — { axis: JOY_AXIS_*, value: float }   triggers / sticks

const DEFAULT_DEADZONE := 0.2

const ACTIONS_P1 := {
	"p1_accelerate": {
		"keys":    [KEY_W, KEY_UP],
		"axis":    {"axis": JOY_AXIS_TRIGGER_RIGHT, "value": 0.5},
	},
	"p1_brake": {
		"keys":    [KEY_S, KEY_DOWN],
		"axis":    {"axis": JOY_AXIS_TRIGGER_LEFT, "value": 0.5},
	},
	"p1_steer_left": {
		"keys":    [KEY_A, KEY_LEFT],
		"axis":    {"axis": JOY_AXIS_LEFT_X, "value": -0.5},
	},
	"p1_steer_right": {
		"keys":    [KEY_D, KEY_RIGHT],
		"axis":    {"axis": JOY_AXIS_LEFT_X, "value": 0.5},
	},
	"p1_fire": {
		"keys":    [KEY_SPACE],
		"buttons": [JOY_BUTTON_A],
	},
	"p1_mine": {
		"keys":    [KEY_SHIFT],
		"buttons": [JOY_BUTTON_B],
	},
	"p1_nitro": {
		"keys":    [KEY_E],
		"buttons": [JOY_BUTTON_X],
	},
	"p1_pause": {
		"keys":    [KEY_ESCAPE],
		"buttons": [JOY_BUTTON_START],
	},
}


func _ready() -> void:
	_register_actions(ACTIONS_P1, 0)
	print("InputManager: %d actions registered for P1." % ACTIONS_P1.size())


func _register_actions(actions: Dictionary, device: int) -> void:
	for action_name in actions:
		if not InputMap.has_action(action_name):
			InputMap.add_action(action_name, DEFAULT_DEADZONE)

		var cfg: Dictionary = actions[action_name]

		for key in cfg.get("keys", []):
			var key_event := InputEventKey.new()
			key_event.physical_keycode = key
			InputMap.action_add_event(action_name, key_event)

		for btn in cfg.get("buttons", []):
			var btn_event := InputEventJoypadButton.new()
			btn_event.button_index = btn
			btn_event.device = device
			InputMap.action_add_event(action_name, btn_event)

		if cfg.has("axis"):
			var ax: Dictionary = cfg["axis"]
			var axis_event := InputEventJoypadMotion.new()
			axis_event.axis = ax["axis"]
			axis_event.axis_value = ax["value"]
			axis_event.device = device
			InputMap.action_add_event(action_name, axis_event)


# Convenience accessors used by the car controller (added later).
func steering(player: int = 0) -> float:
	if player == 0:
		return Input.get_axis("p1_steer_left", "p1_steer_right")
	return 0.0


func throttle(player: int = 0) -> float:
	if player == 0:
		return Input.get_action_strength("p1_accelerate") - Input.get_action_strength("p1_brake")
	return 0.0


# Rumble helper. Web has GamepadHapticActuator support varying by browser —
# Godot's Input.start_joy_vibration handles "if available" gracefully.
func rumble(device: int, weak: float, strong: float, duration: float) -> void:
	Input.start_joy_vibration(device, weak, strong, duration)
