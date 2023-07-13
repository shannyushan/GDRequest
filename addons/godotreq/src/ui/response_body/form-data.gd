@tool
extends TabBar

@onready var table_component := $MarginContainer/TableComponent


func get_request_body():
#	[todo] url encode
	table_component.get_data()
	return {
		"data": "",
		"type": "multipart/form-data"
	}
