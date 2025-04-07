class_name Nexus
extends Node2D

@export var nexus_ui_scene: PackedScene
@onready var beacon = $Beacon
var is_transmitting_beacon = true

var nexus_ui_instance: Node = null

func _ready() -> void:
	toggle_nexus_beacon()
	
func dock_with_nexus():
	if nexus_ui_instance == null:
		nexus_ui_instance = nexus_ui_scene.instantiate()
		get_tree().get_root().get_node("Space").get_node("UI").add_child(nexus_ui_instance)
	nexus_ui_instance.show_docking_ui("Nexus")

func toggle_nexus_beacon():
	is_transmitting_beacon = !is_transmitting_beacon
	beacon.set_arrow_visible(is_transmitting_beacon)

func disable_nexus_transmit():
	is_transmitting_beacon = false
	beacon.set_arrow_visible(is_transmitting_beacon)

func _on_docking_station_entered(body: Node2D) -> void:
	if body is Ship:
		dock_with_nexus()

func _on_docking_station_exited(body: Node2D) -> void:
	if body is Ship and !nexus_ui_instance == null:
		nexus_ui_instance.cancel_dock()
