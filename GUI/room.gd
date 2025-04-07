class_name Room
extends Node2D

@export var room_resource: RoomResource

func get_scenarios():
	var scenarios = LocationData.location_data[room_resource.name]
	print(scenarios)
	
