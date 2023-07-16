@tool
extends TabBar

@onready var table_component := $MarginContainer/TableComponent


func get_request_body():
	var request_data : Dictionary = table_component.get_data()
	var request_form_url_encoded = ""
	
	for data in request_data:
		request_form_url_encoded +=  "%s=%s&" % [data["key"], data["value"].uri_encode()]
	
	request_form_url_encoded.rstrip("&")
	
	return {
		"data": request_form_url_encoded,
		"type": "application/x-www-form-urlencoded"
	}
