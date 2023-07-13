@tool
extends HBoxContainer

signal component_edited(p_self)

@onready var _checkbox :CheckBox= $CheckBoxContainer/CheckBox
@onready var _query_key := $KeyContainer/Key
@onready var _query_value := $ValueContainer/Value
@onready var _delete_btn := $DeleteControl/DeleteButton


var first_edit : bool = true
var is_checked : bool = false : set = set_is_checked


func _on_key_text_changed(new_text):
	_emit_signal_on_first_edit()


func _on_value_text_changed(new_text):
	_emit_signal_on_first_edit()


func _emit_signal_on_first_edit():
	if first_edit:
		#first edit
		first_edit = false
		is_checked = true
		_checkbox.set_pressed_no_signal(true)
		
		component_edited.emit(
			self
		)


func _on_delete_button_pressed():
	queue_free()


func get_data() -> Dictionary:
	return {
		"key": _query_key.text,
		"value" : _query_value.text
	}


func set_default_data(p_default_data : Dictionary)-> void:
	_query_key.text = p_default_data["key"]
	_query_value.text = p_default_data["value"]


func set_is_checked(p_is_checked) -> void:
	is_checked = p_is_checked
	_checkbox.set_pressed_no_signal(p_is_checked)


func set_row_editable(p_is_editable : bool) -> void:
	_query_key.editable = p_is_editable
	_query_value.editable = p_is_editable
	if !p_is_editable:
		_delete_btn.hide()
		_checkbox.hide()


func _on_check_box_toggled(button_pressed):
	is_checked = button_pressed
