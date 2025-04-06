class_name RoomResource
extends Resource

@export var name: String
@export_multiline var description: String

var scenario: Array[String]

func load_room():
	var location_data = LocationData.location_data[name]
	print(location_data)
