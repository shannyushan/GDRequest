extends TabBar

@onready var table_component := $MarginContainer/TableComponent


func get_response_body():
#	[todo] url encode
	table_component.get_data()
	return {
		"data": "",
		"type": "application/x-www-form-urlencoded"
	}
