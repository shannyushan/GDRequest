@tool
extends MenuButton

var popup : PopupMenu

var selected_index : int = -1 

func _ready():
	popup = get_popup()
	popup.index_pressed.connect(_on_index_selected)


func initialize(p_orderded_methods : Array, p_valid_http_methods : Dictionary) -> void:
	popup = get_popup()
	popup.clear()
	
	for method in p_orderded_methods:
		popup.add_item(p_valid_http_methods[method], method)
	
	popup.set_focused_item(0)
	selected_index = 0


func _on_index_selected(p_index: int) -> void:
	text = popup.get_item_text(p_index)
	selected_index = p_index


func get_active_method() -> int:
	print("Focused item is :", selected_index)
	return popup.get_item_id(selected_index)
