@tool
extends MarginContainer

@onready var _request_body_container : TabContainer = $TabContainer


func get_request_body():
	var selected_request_body = _request_body_container.get_current_tab_control()
	return selected_request_body.get_request_body()
