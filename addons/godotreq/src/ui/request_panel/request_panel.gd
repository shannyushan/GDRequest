@tool
extends TabBar

signal send_request(
	p_request_type,
	p_request_url,
	p_request_params,
	p_request_headers,
	p_request_body
)

@onready var request_container = $MarginContainer/ScrollContainer/VSplit/VBoxContainer/RequestContainer
@onready var response_container = $MarginContainer/ScrollContainer/VSplit/ResponseContainer


func initialize(
	p_name: String,
	p_request_details : Dictionary,
	p_response_details : Dictionary = {}
	):
	name = p_name
	
	request_container.initialize(p_request_details)
	response_container.initialize(p_response_details)


func _on_request_container_send_request(
	p_request_type,
	p_request_url,
	p_request_params,
	p_request_headers,
	p_request_body
):
	send_request.emit(
		p_request_type,
		p_request_url,
		p_request_params,
		p_request_headers,
		p_request_body
	)


func on_response_received(
	p_result : int,
	p_response_code : int,
	p_headers,
	p_body,
	p_response_size,
	p_response_time,
) -> void:
	
	response_container.on_response_received(
		p_result,
		p_response_code,
		p_headers,
		p_body,
		p_response_size,
		p_response_time,
	)
