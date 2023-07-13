@tool
extends VBoxContainer

signal send_request(
	p_request_type,
	p_request_url,
	p_request_params,
	p_request_headers,
	p_request_body
)

var valid_http_methods = {
	HTTPClient.METHOD_GET: "GET",
	HTTPClient.METHOD_HEAD: "HEAD",
	HTTPClient.METHOD_POST: "POST",
	HTTPClient.METHOD_PUT: "PUT",
	HTTPClient.METHOD_DELETE: "DELETE",
	HTTPClient.METHOD_OPTIONS: "OPTIONS",
	HTTPClient.METHOD_TRACE: "TRACE",
	HTTPClient.METHOD_CONNECT: "CONNECT",
	HTTPClient.METHOD_PATCH: "PATCH"
}

var default_request_headers : Array = [
	{
		"key": "Content-Type",
		"value": "<Added when sending request>"
	},
	{
		"key": "User-Agent",
#		"value": "curl"
		"value": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.95 Safari/537.36",
	},
	{
		"key": "Accept-Encoding",
		"value": "gzip, deflate, br",
	},
	{
		"key": "Accept",
#		"value": "text/html, application/xhtml+xml, application/json, application/xml;q=0.9,*/*;q=0.8",
		"value": "*/*",
	},
	{
		"key": "Accept-Language",
		"value": "en-us",
	}

]

@onready var _http_method_menu := $RequestControl/HBoxContainer/HBoxContainer/HttpMenuButton
@onready var _request_url := $RequestControl/HBoxContainer/HBoxContainer/RequestUrl

@onready var _request_params := $RequestOptions/Params/MarginContainer/VBoxContainer/ParamComponent
@onready var _request_headers := $RequestOptions/Headers/MarginContainer/VBoxContainer/HeaderComponent

@onready var _request_body := $RequestOptions/Body/RequestBody


# Called when the node enters the scene tree for the first time.
func _ready():
	_http_method_menu.initialize(
		get_ordered_http_methods(),
		valid_http_methods
	)
	_request_headers.set_default_data(default_request_headers)


func get_ordered_http_methods() -> Array:
	return [
		HTTPClient.METHOD_GET,
		HTTPClient.METHOD_HEAD,
		HTTPClient.METHOD_POST,
		HTTPClient.METHOD_PUT,
		HTTPClient.METHOD_DELETE,
		HTTPClient.METHOD_OPTIONS,
		HTTPClient.METHOD_TRACE,
		HTTPClient.METHOD_CONNECT,
		HTTPClient.METHOD_PATCH
	]


func _on_send_pressed():
	on_send_request_btn_clicked()


func on_send_request_btn_clicked():
	var request_type = get_active_request_method()
	var query_params : Dictionary = _request_params.get_data()
	var request_headers : Dictionary = _request_headers.get_data()
	
	var request_url :String = _request_url.text
	
	var request_body : Dictionary = _request_body.get_request_body()
	
	if request_body["data"] == "" and request_headers.has("Content-Type"):
		request_headers.erase("Content-Type")
	if request_body["data"] != "":
		request_headers["Content-Type"] = request_body["type"]
	
	
	request_headers["Host"] = get_host_from_url(request_url)
	request_headers["Cache-Control"] = "must-revalidate"
	request_headers["Pragma"] = "no-cache"
	request_headers["Expires"] = "0"
	
	
	send_request.emit(
		request_type,
		request_url,
		query_params,
		request_headers,
		request_body
	)


func get_host_from_url(p_url: String) -> String:
	var pattern = "^(?:https?:\\/\\/)?(?:[^@\\n]+@)?(?:www\\.)?([^:\\/\\n?]+)"
	
	var regex = RegEx.new()
	regex.compile(pattern)
	
	var matches : RegExMatch = regex.search(p_url)
	
	if matches != null:
		return matches.strings[1]
	else:
		return ""


func get_active_request_method() -> int:
	return _http_method_menu.get_active_method()


func get_request_url() -> String:
	return _request_url.text
