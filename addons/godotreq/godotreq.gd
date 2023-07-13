@tool
extends EditorPlugin

var _main_dock


func _enter_tree():
	
	_register_autoloads()

	_main_dock = preload("res://addons/godotreq/src/dock/dock.tscn").instantiate()

#	UpperLeftDock
	add_control_to_bottom_panel(_main_dock, "GodotRequest")
#	add_control_to_dock(DOCK_SLOT_RIGHT_UL, _main_dock)


func _register_autoloads() -> void:
	add_autoload_singleton("GEventBus", "res://addons/godotreq/src/autoload/gevents.gd")


func _unregister_autoloads() -> void:
	remove_autoload_singleton("GEventBus")


func _exit_tree():
	remove_control_from_bottom_panel(_main_dock)
#	remove_control_from_docks(_main_dock)
	_main_dock.free()
