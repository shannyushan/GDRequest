@tool
extends VBoxContainer

const RESPONSE_CODE_COLORS : Dictionary = {
	HTTPClient.RESPONSE_CONTINUE: Color(0.85, 0.85, 0.85),
	HTTPClient.RESPONSE_SWITCHING_PROTOCOLS: Color(0.85, 0.85, 0.84),
	HTTPClient.RESPONSE_PROCESSING: Color(0.85, 0.85, 0.83),
	HTTPClient.RESPONSE_OK: Color(0.84, 0.85, 0.83),
	HTTPClient.RESPONSE_CREATED: Color(0.84, 0.85, 0.82),
	HTTPClient.RESPONSE_ACCEPTED: Color(0.83, 0.85, 0.82),
	HTTPClient.RESPONSE_NON_AUTHORITATIVE_INFORMATION: Color(0.83, 0.85, 0.81),
	HTTPClient.RESPONSE_NO_CONTENT: Color(0.82, 0.85, 0.81),
	HTTPClient.RESPONSE_RESET_CONTENT: Color(0.82, 0.85, 0.80),
	HTTPClient.RESPONSE_PARTIAL_CONTENT: Color(0.81, 0.85, 0.80),
	HTTPClient.RESPONSE_MULTI_STATUS: Color(0.81, 0.85, 0.79),
	HTTPClient.RESPONSE_ALREADY_REPORTED: Color(0.80, 0.85, 0.79),
	HTTPClient.RESPONSE_IM_USED: Color(0.80, 0.85, 0.78),
	HTTPClient.RESPONSE_MULTIPLE_CHOICES: Color(0.79, 0.85, 0.78),
	HTTPClient.RESPONSE_MOVED_PERMANENTLY: Color(0.79, 0.85, 0.77),
	HTTPClient.RESPONSE_FOUND: Color(0.78, 0.85, 0.77),
	HTTPClient.RESPONSE_SEE_OTHER: Color(0.78, 0.85, 0.76),
	HTTPClient.RESPONSE_NOT_MODIFIED: Color(0.77, 0.85, 0.76),
	HTTPClient.RESPONSE_USE_PROXY: Color(0.77, 0.85, 0.75),
	HTTPClient.RESPONSE_SWITCH_PROXY: Color(0.76, 0.85, 0.75),
	HTTPClient.RESPONSE_TEMPORARY_REDIRECT: Color(0.76, 0.85, 0.74),
	HTTPClient.RESPONSE_PERMANENT_REDIRECT: Color(0.75, 0.85, 0.74),
	HTTPClient.RESPONSE_BAD_REQUEST: Color(0.75, 0.85, 0.73),
	HTTPClient.RESPONSE_UNAUTHORIZED: Color(0.74, 0.85, 0.73),
	HTTPClient.RESPONSE_PAYMENT_REQUIRED: Color(0.74, 0.85, 0.72),
	HTTPClient.RESPONSE_FORBIDDEN: Color(0.73, 0.85, 0.72),
	HTTPClient.RESPONSE_NOT_FOUND: Color(0.73, 0.85, 0.71),
	HTTPClient.RESPONSE_METHOD_NOT_ALLOWED: Color(0.72, 0.85, 0.71),
	HTTPClient.RESPONSE_NOT_ACCEPTABLE: Color(0.72, 0.85, 0.70),
	HTTPClient.RESPONSE_PROXY_AUTHENTICATION_REQUIRED: Color(0.71, 0.85, 0.70),
	HTTPClient.RESPONSE_REQUEST_TIMEOUT: Color(0.71, 0.85, 0.69),
	HTTPClient.RESPONSE_CONFLICT: Color(0.70, 0.85, 0.69),
	HTTPClient.RESPONSE_GONE: Color(0.70, 0.85, 0.68),
	HTTPClient.RESPONSE_LENGTH_REQUIRED: Color(0.69, 0.85, 0.68),
	HTTPClient.RESPONSE_PRECONDITION_FAILED: Color(0.69, 0.85, 0.67),
	HTTPClient.RESPONSE_REQUEST_ENTITY_TOO_LARGE: Color(0.68, 0.85, 0.67),
	HTTPClient.RESPONSE_REQUEST_URI_TOO_LONG: Color(0.68, 0.85, 0.66),
	HTTPClient.RESPONSE_UNSUPPORTED_MEDIA_TYPE: Color(0.67, 0.85, 0.66),
	HTTPClient.RESPONSE_REQUESTED_RANGE_NOT_SATISFIABLE: Color(0.67, 0.85, 0.65),
	HTTPClient.RESPONSE_EXPECTATION_FAILED: Color(0.66, 0.85, 0.65),
	HTTPClient.RESPONSE_IM_A_TEAPOT: Color(0.66, 0.85, 0.64),
	HTTPClient.RESPONSE_MISDIRECTED_REQUEST: Color(0.65, 0.85, 0.64),
	HTTPClient.RESPONSE_UNPROCESSABLE_ENTITY: Color(0.65, 0.85, 0.63),
	HTTPClient.RESPONSE_LOCKED: Color(0.64, 0.85, 0.63),
	HTTPClient.RESPONSE_FAILED_DEPENDENCY: Color(0.64, 0.85, 0.62),
	HTTPClient.RESPONSE_UPGRADE_REQUIRED: Color(0.63, 0.85, 0.62),
	HTTPClient.RESPONSE_PRECONDITION_REQUIRED: Color(0.63, 0.85, 0.61),
	HTTPClient.RESPONSE_TOO_MANY_REQUESTS: Color(0.62, 0.85, 0.61),
	HTTPClient.RESPONSE_REQUEST_HEADER_FIELDS_TOO_LARGE: Color(0.62, 0.85, 0.60),
	HTTPClient.RESPONSE_UNAVAILABLE_FOR_LEGAL_REASONS: Color(0.61, 0.85, 0.60),
	HTTPClient.RESPONSE_INTERNAL_SERVER_ERROR: Color(0.61, 0.85, 0.59),
	HTTPClient.RESPONSE_NOT_IMPLEMENTED: Color(0.60, 0.85, 0.58),
	HTTPClient.RESPONSE_BAD_GATEWAY: Color(0.59, 0.85, 0.58),
	HTTPClient.RESPONSE_SERVICE_UNAVAILABLE: Color(0.59, 0.85, 0.57),
	HTTPClient.RESPONSE_GATEWAY_TIMEOUT: Color(0.58, 0.85, 0.57),
	HTTPClient.RESPONSE_HTTP_VERSION_NOT_SUPPORTED: Color(0.58, 0.85, 0.56),
	HTTPClient.RESPONSE_VARIANT_ALSO_NEGOTIATES: Color(0.57, 0.85, 0.56),
	HTTPClient.RESPONSE_INSUFFICIENT_STORAGE: Color(0.57, 0.85, 0.55),
	HTTPClient.RESPONSE_LOOP_DETECTED: Color(0.56, 0.85, 0.55),
	HTTPClient.RESPONSE_NOT_EXTENDED: Color(0.56, 0.85, 0.54),
	HTTPClient.RESPONSE_NETWORK_AUTH_REQUIRED: Color(0.55, 0.85, 0.54),
}

const RESPONSE_CODE_SHORT_KEYS : Dictionary = {
	HTTPClient.RESPONSE_CONTINUE: "CONTINUE",
	HTTPClient.RESPONSE_SWITCHING_PROTOCOLS: "SWITCH_PROTOCOLS",
	HTTPClient.RESPONSE_PROCESSING: "PROCESSING",
	HTTPClient.RESPONSE_OK: "OK",
	HTTPClient.RESPONSE_CREATED: "CREATED",
	HTTPClient.RESPONSE_ACCEPTED: "ACCEPTED",
	HTTPClient.RESPONSE_NON_AUTHORITATIVE_INFORMATION: "NON_AUTH_INFO",
	HTTPClient.RESPONSE_NO_CONTENT: "NO_CONTENT",
	HTTPClient.RESPONSE_RESET_CONTENT: "RESET_CONTENT",
	HTTPClient.RESPONSE_PARTIAL_CONTENT: "PARTIAL_CONTENT",
	HTTPClient.RESPONSE_MULTI_STATUS: "MULTI_STATUS",
	HTTPClient.RESPONSE_ALREADY_REPORTED: "ALREADY_REPORTED",
	HTTPClient.RESPONSE_IM_USED: "IM_USED",
	HTTPClient.RESPONSE_MULTIPLE_CHOICES: "MULTIPLE_CHOICES",
	HTTPClient.RESPONSE_MOVED_PERMANENTLY: "MOVED_PERMANENTLY",
	HTTPClient.RESPONSE_FOUND: "FOUND",
	HTTPClient.RESPONSE_SEE_OTHER: "SEE_OTHER",
	HTTPClient.RESPONSE_NOT_MODIFIED: "NOT_MODIFIED",
	HTTPClient.RESPONSE_USE_PROXY: "USE_PROXY",
	HTTPClient.RESPONSE_SWITCH_PROXY: "SWITCH_PROXY",
	HTTPClient.RESPONSE_TEMPORARY_REDIRECT: "TEMP_REDIRECT",
	HTTPClient.RESPONSE_PERMANENT_REDIRECT: "PERM_REDIRECT",
	HTTPClient.RESPONSE_BAD_REQUEST: "BAD_REQUEST",
	HTTPClient.RESPONSE_UNAUTHORIZED: "UNAUTHORIZED",
	HTTPClient.RESPONSE_PAYMENT_REQUIRED: "PAYMENT_REQUIRED",
	HTTPClient.RESPONSE_FORBIDDEN: "FORBIDDEN",
	HTTPClient.RESPONSE_NOT_FOUND: "NOT_FOUND",
	HTTPClient.RESPONSE_METHOD_NOT_ALLOWED: "METHOD_NOT_ALLOWED",
	HTTPClient.RESPONSE_NOT_ACCEPTABLE: "NOT_ACCEPTABLE",
	HTTPClient.RESPONSE_PROXY_AUTHENTICATION_REQUIRED: "PROXY_AUTH_REQ",
	HTTPClient.RESPONSE_REQUEST_TIMEOUT: "REQUEST_TIMEOUT",
	HTTPClient.RESPONSE_CONFLICT: "CONFLICT",
	HTTPClient.RESPONSE_GONE: "GONE",
	HTTPClient.RESPONSE_LENGTH_REQUIRED: "LENGTH_REQUIRED",
	HTTPClient.RESPONSE_PRECONDITION_FAILED: "PRECONDITION_FAILED",
	HTTPClient.RESPONSE_REQUEST_ENTITY_TOO_LARGE: "ENTITY_TOO_LARGE",
	HTTPClient.RESPONSE_REQUEST_URI_TOO_LONG: "URI_TOO_LONG",
	HTTPClient.RESPONSE_UNSUPPORTED_MEDIA_TYPE: "UNSUPPORTED_MEDIA",
	HTTPClient.RESPONSE_REQUESTED_RANGE_NOT_SATISFIABLE: "RANGE_NOT_SATISFIABLE",
	HTTPClient.RESPONSE_EXPECTATION_FAILED: "EXPECTATION_FAILED",
	HTTPClient.RESPONSE_IM_A_TEAPOT: "I_AM_A_TEAPOT",
	HTTPClient.RESPONSE_MISDIRECTED_REQUEST: "MISDIRECTED_REQUEST",
	HTTPClient.RESPONSE_UNPROCESSABLE_ENTITY: "UNPROCESSABLE_ENTITY",
	HTTPClient.RESPONSE_LOCKED: "LOCKED",
	HTTPClient.RESPONSE_FAILED_DEPENDENCY: "FAILED_DEPENDENCY",
	HTTPClient.RESPONSE_UPGRADE_REQUIRED: "UPGRADE_REQUIRED",
	HTTPClient.RESPONSE_PRECONDITION_REQUIRED: "PRECONDITION_REQUIRED",
	HTTPClient.RESPONSE_TOO_MANY_REQUESTS: "TOO_MANY_REQUESTS",
	HTTPClient.RESPONSE_REQUEST_HEADER_FIELDS_TOO_LARGE: "FIELDS_TOO_LARGE",
	HTTPClient.RESPONSE_UNAVAILABLE_FOR_LEGAL_REASONS: "LEGAL_UNAVAILABLE",
	HTTPClient.RESPONSE_INTERNAL_SERVER_ERROR: "INTERNAL_ERROR",
	HTTPClient.RESPONSE_NOT_IMPLEMENTED: "NOT_IMPLEMENTED",
	HTTPClient.RESPONSE_BAD_GATEWAY: "BAD_GATEWAY",
	HTTPClient.RESPONSE_SERVICE_UNAVAILABLE: "SERVICE_UNAVAILABLE",
	HTTPClient.RESPONSE_GATEWAY_TIMEOUT: "GATEWAY_TIMEOUT",
	HTTPClient.RESPONSE_HTTP_VERSION_NOT_SUPPORTED: "HTTP_VERSION_NOT_SUPPORTED",
	HTTPClient.RESPONSE_VARIANT_ALSO_NEGOTIATES: "VARIANT_ALSO_NEGOTIATES",
	HTTPClient.RESPONSE_INSUFFICIENT_STORAGE: "INSUFFICIENT_STORAGE",
	HTTPClient.RESPONSE_LOOP_DETECTED: "LOOP_DETECTED",
	HTTPClient.RESPONSE_NOT_EXTENDED: "NOT_EXTENDED",
	HTTPClient.RESPONSE_NETWORK_AUTH_REQUIRED: "NETWORK_AUTH_REQUIRED",
}

@onready var _response_code := $HBoxContainer/MarginContainer/ResponseDetail/ResponseCode/value
@onready var _response_time := $HBoxContainer/MarginContainer/ResponseDetail/ResponseTime/value
@onready var _response_size := $HBoxContainer/MarginContainer/ResponseDetail/ResponseSize/value

@onready var _response_headers := $HBoxContainer/PanelContainer/TabContainer/Headers/MarginContainer/ResponseHeaders
@onready var _raw_view := $HBoxContainer/PanelContainer/TabContainer/Body/MarginContainer/TabContainer/Raw/TextEdit
@onready var _json_view := $HBoxContainer/PanelContainer/TabContainer/Body/MarginContainer/TabContainer/JSON/MarginContainer/VBoxContainer/JSON

@onready var _preview_image := $HBoxContainer/PanelContainer/TabContainer/Body/MarginContainer/TabContainer/Preview/MarginContainer/VBoxContainer/TextureRect
@onready var _preview_label := $HBoxContainer/PanelContainer/TabContainer/Body/MarginContainer/TabContainer/Preview/MarginContainer/VBoxContainer/Label


func on_response_received(
	p_result : int,
	p_response_code : int,
	p_headers,
	p_body,
	p_response_size,
	p_response_time
) -> void:
	_set_response_code(p_response_code)
	_set_response_time(p_response_time)
	_set_response_size(p_response_size)
	
	var response_header : Dictionary = _get_dict_response_header(p_headers)
	
	_set_response_headers(response_header)
	var content_type = response_header.get("Content-Type")
	
	if content_type == null:
		content_type = response_header.get("content-type")
		
	_set_response_data(p_body, content_type)


func _set_response_data(p_body: PackedByteArray, p_content_type: String ) -> void:
	var content_type_split = p_content_type.split(";")[0]
	var response_body: String = ""
	
	if !content_type_split.contains("image"):
		response_body = p_body.get_string_from_utf8()
		_raw_view.text = response_body
		
	if p_content_type == "":
		return
		
	content_type_split = content_type_split.split("/")
	
	if content_type_split.size() < 1:
		return
	
	if content_type_split[1] == "json" || content_type_split[1] == "javascript":
		var response_body_json = JSON.parse_string(response_body)
		
		if response_body_json == null:
			_json_view.text = "Unable to Parse"
			return
		_json_view.text = JSON.stringify(response_body_json, "\t")
		return
		
	if content_type_split[1] in ["jpeg", "jpg", "png", "bmp", "webp"]:
		var image: Image = load_image_from_buffer(p_body, content_type_split[1])
		
		if image == null:
			return
		
		var image_texture: ImageTexture = ImageTexture.create_from_image(image)
		_preview_image.texture = image_texture


func load_image_from_buffer(p_image_data: PackedByteArray, p_image_type)-> Image:
	var image = Image.new()
	var error
	match p_image_type:
		"png":
			error = image.load_png_from_buffer(p_image_data)
		"jpg":
			error = image.load_jpg_from_buffer(p_image_data)
		"jpeg":
			error = image.load_jpg_from_buffer(p_image_data)
		"bmp":
			error = image.load_bmp_from_buffer(p_image_data)
		"webp":
			error = image.load_webp_from_buffer(p_image_data)
	return image


func _set_response_headers(p_headers: Dictionary) -> void:
	var response_headers : Array = []
	for header_key in p_headers:
		response_headers.push_back(
			{
				"key": header_key,
				"value": p_headers[header_key]
			}
		)
	_response_headers.clear_all()
	_response_headers.set_default_data(response_headers, false)


func _get_dict_response_header(p_headers: PackedStringArray) -> Dictionary:
	var response_headers : Dictionary = {}
	
	for entry in p_headers:
		var sep = entry.find(":")
		
		response_headers[entry.substr(0, sep)] = entry.substr(sep+1, entry.length())

	return response_headers


func _set_response_time(p_response_time) -> void:
	_response_time.text = "%s ms" % p_response_time


func _set_response_size(p_response_size : int) -> void:
	_response_size.text = "%s KB" % p_response_size


func _set_response_code(p_response_code: int )-> void:
	var color = RESPONSE_CODE_COLORS.get(p_response_code, Color(1,1,1,1))
	_response_code.add_theme_color_override("font_color", RESPONSE_CODE_COLORS.get(p_response_code, Color(1,1,1,1)))
	_response_code.text = "%s %s" % [str(p_response_code), RESPONSE_CODE_SHORT_KEYS.get(p_response_code, "")]
