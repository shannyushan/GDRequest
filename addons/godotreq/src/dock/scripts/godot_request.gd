@tool
extends Control

@onready var _http_request_node: HTTPRequest = $HTTPRequest
@onready var _request_page = $"PanelContainer/MarginContainer/ScrollContainer/HSplitContainer/RequestTabContainer/GodotRequest"

var _request_sent_at : int
var _http_client = HTTPClient.new()

var current_request: RequestData =  null


func _on_http_request_request_completed(
	p_result : int,
	p_response_code : int,
	p_headers,
	p_body
):
	print("""
	Body size: %s
	Response Code : %s
	Download size: %s KB
	Resposne Headers %s

	""" % [
		_http_request_node.get_body_size(),
		p_response_code,
		_http_request_node.get_downloaded_bytes(),
		p_headers
	])
	
	if p_response_code == HTTPClient.RESPONSE_MOVED_PERMANENTLY:
		var location = get_dict_response_from_packed_string(p_headers).get("Location")
		print("""
		Redirecting to%s
		""" % location)
		if location != null:
			pass
			_on_untitled_request_send_request(
				current_request.request_type,
				location.lstrip(" "),
				current_request.request_params,
				current_request.request_headers,
				current_request.request_body,
			)
			return
		
	_request_page.on_response_received(
		p_result,
		p_response_code,
		p_headers,
		p_body,
		_http_request_node.get_body_size(),
		Time.get_ticks_msec() - _request_sent_at
	)


func _on_untitled_request_send_request(
	p_request_type : int,
	p_request_url : String,
	p_request_params,
	p_request_headers,
	p_request_body
):
	_http_request_node.cancel_request()
	
	current_request =  RequestData.new(
		p_request_type,
		p_request_url,
		p_request_params,
		p_request_headers,
		p_request_body
	)
	
	var query_string : String = ""
	
	if p_request_type == HTTPClient.METHOD_GET:
		if p_request_params != null && !p_request_params.is_empty():
			query_string = _http_client.query_string_from_dict(p_request_params)
			p_request_url += "?" + query_string
	
	var custom_header = PackedStringArray()
	
	if p_request_headers != null && !p_request_headers.is_empty():
		custom_header = get_packed_string_array_from_dict(p_request_headers)
	
	var request_body = "" if p_request_body["data"] == "" else p_request_body["data"]
	
	print("""
	Request_type : %s 
	Request_url : %s
	Request_params: %s
	Request_headers: %s
	Request_body: %s
	""" %[
		p_request_type,
		p_request_url,
		query_string,
		custom_header,
		request_body
	])
	_request_sent_at =  Time.get_ticks_msec()
	
	_http_request_node.request(
		p_request_url,
		custom_header,
		p_request_type,
		request_body
	)



func get_dict_response_from_packed_string(p_headers: PackedStringArray) -> Dictionary:
	var response_headers : Dictionary = {}
	
	for entry in p_headers:
		var sep = entry.find(":")
		
		response_headers[entry.substr(0, sep)] = entry.substr(sep+1, entry.length())

	return response_headers


func get_packed_string_array_from_dict(p_dictionary : Dictionary) -> PackedStringArray:
	var packed_string_array = PackedStringArray()
	for key in p_dictionary:
		packed_string_array.append(
			"%s: %s" % [key, p_dictionary[key]]
		)
	return packed_string_array


class RequestData:
	var request_type : int = -1
	var request_url:String =""
	var request_params
	var request_headers
	var request_body
	
	func _init(
		p_request_type : int,
		p_request_url : String,
		p_request_params,
		p_request_headers,
		p_request_body
	) : 
		request_type= p_request_type
		request_url = p_request_url
		request_params = p_request_params
		request_headers = p_request_headers
		request_body = p_request_body
