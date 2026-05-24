extends Node

# Global game state singleton (autoload).
# Holds palette, version, and shared session flags.
# Scenes read from here instead of duplicating constants.

const VERSION := "0.1.0-dev"

const PALETTE := {
	"asphalt":    Color8(0x1A, 0x1A, 0x22),
	"vinyl":      Color8(0x0A, 0x0A, 0x0A),
	"neon_pink":  Color8(0xFF, 0x2D, 0x87),
	"neon_cyan":  Color8(0x2D, 0xE1, 0xFC),
	"hot_red":    Color8(0xE6, 0x39, 0x46),
	"hot_yellow": Color8(0xFF, 0xD2, 0x3F),
	"chrome":     Color8(0xD9, 0xD9, 0xD9),
	"cream":      Color8(0xF4, 0xE9, 0xCD),
}

# Selected at the menu, read by the race scene.
var split_screen: bool = false

# Set true on first connected gamepad input; used to swap on-screen glyphs.
var last_input_was_gamepad: bool = false


func _ready() -> void:
	print("Rock 'n' Roll Racing Clone v%s" % VERSION)
	print("Platform: %s | web=%s" % [OS.get_name(), OS.has_feature("web")])


func _input(event: InputEvent) -> void:
	if event is InputEventJoypadButton or event is InputEventJoypadMotion:
		last_input_was_gamepad = true
	elif event is InputEventKey or event is InputEventMouseButton:
		last_input_was_gamepad = false
