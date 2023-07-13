@tool
extends TabBar

@onready var raw_type_menu :MenuButton = $Control/MenuButton
@onready var code_edit : CodeEdit = $Control/MarginContainer/CodeEdit
@onready var menubutton: MenuButton = $Control/MenuButton

var popup : PopupMenu
var selected_index = -1


func _ready():
	popup = raw_type_menu.get_popup()
	popup.set_focused_item(0)
		
	popup.index_pressed.connect(_on_request_type_changed)


func get_request_body():
	var payload = code_edit.text
	popup = raw_type_menu.get_popup()
	
	if selected_index == -1:
		selected_index = popup.get_focused_item()
	
	var focused_selection = popup.get_item_text(selected_index)
	
	if focused_selection =="JSON":
		return {
			"data": code_edit.text,
			"type": "application/html"
		}
		
	elif focused_selection =="HTML":
		return {
			"data": code_edit.text,
			"type": "text/html"
		}
	
	return {
		"data": code_edit.text,
		"type": "text/html"
	}


func _on_request_type_changed(p_index: int) -> void:
	selected_index = p_index
	menubutton.text = popup.get_item_text(p_index)

