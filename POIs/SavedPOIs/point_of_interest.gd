class_name PointOfInterest
extends Node2D

@export var poi_ui_scene: PackedScene
@export var POI_resource: POIResource 

var available_rooms: Array[RoomResource]
var first_room: RoomResource
var second_room: RoomResource
var third_room: RoomResource

var poi_ui_instance: Node = null

@onready var beacon: Beacon = $Beacon
var is_locked: bool = false

func _ready() -> void:
	select_two_rooms()

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
	
func dock_with_poi():
	if poi_ui_instance == null:
		poi_ui_instance = poi_ui_scene.instantiate()
		poi_ui_instance.set_poi(self)
		get_tree().get_root().get_node("Space").get_node("UI").add_child(poi_ui_instance)
	poi_ui_instance.show_docking_ui(POI_resource.get_title(), POI_resource.description, first_room, second_room, third_room)

func lock_poi():
	is_locked = true
	var sprite = $Sprite2D
	beacon.set_beacon_disabled()
	sprite.self_modulate = Color(0.5, 0.5, 0.5, 1.0)

func _on_docking_station_entered(body: Node2D) -> void:
	if is_locked:
		return
	if body is Ship:
		dock_with_poi()


func _on_docking_station_exited(body: Node2D) -> void:
	if is_locked:
		return
	if body is Ship:
		poi_ui_instance.cancel_dock()
