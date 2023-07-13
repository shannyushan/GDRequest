@tool
extends Control

var query_params: Dictionary = {}

func _ready():
	# Create UI elements
	var vbox = VBoxContainer.new()
	add_child(vbox)
	
	var param_label = Label.new()
	param_label.text = "Query Parameters:"
	vbox.add_child(param_label)
	
	# Add an initial row for query parameter entry
	add_query_param_row(vbox)

	var add_button = Button.new()
	add_button.text = "Add Parameter"
	add_button.pressed.connect(_on_add_parameter_pressed.bind(vbox))
	vbox.add_child(add_button)

# Method to add a new query parameter row
func add_query_param_row(container: VBoxContainer):
	var hbox = HBoxContainer.new()
	
	var key_input = LineEdit.new()
	key_input.placeholder_text = "Key"
	hbox.add_child(key_input)
	
	var value_input = LineEdit.new()
	value_input.placeholder_text = "Value"
	hbox.add_child(value_input)
	
	var remove_button = Button.new()
	remove_button.text = "Remove"
	remove_button.pressed.connect(_on_remove_parameter_pressed.bind(container, hbox))
	hbox.add_child(remove_button)
	
	container.add_child(hbox)

# Signal handler for "Add Parameter" button press
func _on_add_parameter_pressed(container: VBoxContainer):
	add_query_param_row(container)

# Signal handler for "Remove" button press
func _on_remove_parameter_pressed(container: VBoxContainer, row: HBoxContainer):
	container.remove_child(row)

# Method to retrieve the query parameters as a dictionary
func get_query_params() -> Dictionary:
	query_params.clear()
	
	var vbox = get_node("VBoxContainer")
	
	for child in vbox.get_children():
		if child is HBoxContainer:
			var key_input = child.get_node("LineEdit")
			var value_input = child.get_node("LineEdit")
			
			var key = key_input.text.strip_edges()
			var value = value_input.text.strip_edges()
			
			if key != "" and value != "":
				query_params[key] = value
	
	return query_params
