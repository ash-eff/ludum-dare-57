class_name PointOfInterest
extends Node2D

@export var POI_resource: POIResource 

var available_rooms: Array[RoomResource]
var first_room: RoomResource
var second_room: RoomResource

func _ready() -> void:
	SignalBus.location_data_loaded.connect(select_two_rooms)

func select_two_rooms():
	for room in POI_resource.rooms:
		available_rooms.append(room)
	
	first_room = available_rooms.pick_random()
	second_room = available_rooms.pick_random()
	
	while first_room == second_room:
		second_room = available_rooms.pick_random()
		
	get_scenarios()
	
	
func get_scenarios():
	first_room.load_room()
	second_room.load_room()
