extends Node

var location_data = {}  # Dictionary to hold the location data

@export var location_data_file : String = "res://Game/poi_data.json"  # Path to your JSON file

func _ready():
	var file = FileAccess.open(location_data_file, FileAccess.READ)
	if file:
		var json_data = file.get_as_text()
		var json = JSON.new()
		var result = json.parse(json_data)
		if result == OK:
			location_data = json.get_data()
		else:
			print("Error parsing JSON data")
	else:
		print("Failed to open location data file")
