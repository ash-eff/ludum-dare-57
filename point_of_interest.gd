class_name PointOfInterest
extends Node2D

@export var poi_ui_scene: PackedScene
@export var POI_resource: POIResource 

var available_rooms: Array[RoomResource]
var first_room: RoomResource
var second_room: RoomResource
var third_room: RoomResource

var poi_ui_instance: Node = null

func _ready() -> void:
	SignalBus.location_data_loaded.connect(select_two_rooms)

func select_two_rooms():
	for room in POI_resource.rooms:
		available_rooms.append(room)
	
	first_room = available_rooms.pick_random()
	second_room = available_rooms.pick_random()
	
	while first_room == second_room:
		second_room = available_rooms.pick_random()
		
	third_room = available_rooms.pick_random()
	
	while first_room == third_room or second_room == third_room:
		third_room = available_rooms.pick_random()
		
	dock_with_poi()
	
func dock_with_poi():
	if poi_ui_instance == null:
		poi_ui_instance = poi_ui_scene.instantiate()
		get_tree().get_root().get_node("Space").get_node("UI").add_child(poi_ui_instance)
		poi_ui_instance.show_docking_ui(POI_resource.get_title(), POI_resource.description, first_room, second_room, third_room)
	
