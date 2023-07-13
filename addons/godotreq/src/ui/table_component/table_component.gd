@tool
extends VBoxContainer

@export var TableRowComponent: PackedScene
@export var is_editable : bool = true

@onready var row_container := $ScrollContainer/TableContainer
@onready var default_row_component := $ScrollContainer/TableContainer/TableComponent


func _ready():
	default_row_component.component_edited.connect(_on_component_edited.bind(default_row_component))
	default_row_component.set_row_editable(is_editable)


func set_default_data(p_default_datas : Array, p_is_editable: bool = is_editable) -> void:
	for default_data in p_default_datas:
		if default_row_component && is_instance_valid(default_row_component) && default_data == p_default_datas[0]:
			
			if !default_row_component.is_connected("component_edited", _on_component_edited):
				default_row_component.component_edited.connect(_on_component_edited.bind(default_row_component))
			default_row_component.set_default_data(default_data)
			default_row_component.set_is_checked(true)
			default_row_component.set_row_editable(is_editable)
			continue
		
		var new_row_component = _add_new_table_row_component()
		new_row_component.set_default_data(default_data)
		new_row_component.set_is_checked(true)
		new_row_component.set_row_editable(is_editable)


func _on_component_edited(p_self):
	var query_count = row_container.get_child_count() - 1
	var last_child = row_container.get_child(query_count)
	
	if p_self == last_child:
		var __ = _add_new_table_row_component()


func _add_new_table_row_component() -> Node:
	var new_component = TableRowComponent.instantiate()
	new_component.component_edited.connect(_on_component_edited)
	row_container.add_child(new_component)
	return new_component


func get_data() -> Dictionary:
	var data = {}
	for row_component in row_container.get_children():
		if row_component.is_checked:
			var query_data = row_component.get_data()
			data[query_data["key"]] = query_data["value"]
	return data


func clear_all() -> void:
	for child in row_container.get_children():
		child.queue_free()
