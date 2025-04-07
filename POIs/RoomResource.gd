class_name RoomResource
extends Resource

@export var name: String
@export_multiline var description: String
@export var loot_table: LootTableResource

var scenario: Array[String]

func get_room_data() -> Array:
	var room_data = LocationData.location_data[name]
	return room_data
