@tool
extends TabBar

@export var QueryComponent: PackedScene

@onready var query_container := $MarginContainer/VBoxContainer/ScrollContainer/QueryContainer
@onready var default_query_component := $MarginContainer/VBoxContainer/ScrollContainer/QueryContainer/QueryComponent


func _on_query_component_query_component_edited(p_self):
	var query_count = query_container.get_child_count() - 1
	var last_child = query_container.get_child(query_count)
	
	if p_self == last_child:
		var new_component = QueryComponent.instantiate()
		new_component.query_component_edited.connect(_on_query_component_query_component_edited)
		query_container.add_child(new_component)


func get_params() -> Dictionary:
	var params_dictionary = {}
	for query_component in query_container.get_children():
		if query_component.is_checked:
			var query_data = query_component.get_query_data()
			params_dictionary[query_data["key"]] = query_data["value"]
	return params_dictionary
