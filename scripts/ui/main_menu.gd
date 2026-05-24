extends Control

# Main menu: hello-world screen for Milestone 1.
# Verifies palette, typography, and gamepad navigation work end-to-end.

@onready var start_button: Button = $Menu/StartButton
@onready var split_button: Button = $Menu/SplitButton
@onready var options_button: Button = $Menu/OptionsButton
@onready var quit_button: Button = $Menu/QuitButton
@onready var footer: Label = $Footer


func _ready() -> void:
	start_button.grab_focus()
	start_button.pressed.connect(_on_start)
	split_button.pressed.connect(_on_split)
	options_button.pressed.connect(_on_options)
	quit_button.pressed.connect(_on_quit)

	# Hide Quit on web — there's no window to close.
	if OS.has_feature("web"):
		quit_button.hide()

	_update_footer()


func _process(_delta: float) -> void:
	_update_footer()


func _update_footer() -> void:
	var pads := Input.get_connected_joypads()
	var hint := "Keyboard ready"
	if pads.size() > 0:
		hint = "Gamepad: %s" % Input.get_joy_name(pads[0])
	footer.text = "%s   ·   v%s   ·   %s build" % [
		hint,
		Game.VERSION,
		"web" if OS.has_feature("web") else "desktop",
	]


func _on_start() -> void:
	Game.split_screen = false
	print("[menu] Start race — placeholder, race scene lands in Milestone 3.")


func _on_split() -> void:
	Game.split_screen = true
	print("[menu] Split-screen race — placeholder.")


func _on_options() -> void:
	print("[menu] Options — placeholder.")


func _on_quit() -> void:
	if OS.has_feature("web"):
		return
	get_tree().quit()
