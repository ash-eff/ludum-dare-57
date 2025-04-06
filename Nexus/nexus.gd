class_name Nexus
extends Node2D

@onready var beacon = $Beacon
var is_transmitting_beacon = true

func _ready() -> void:
	toggle_nexus_beacon()

func toggle_nexus_beacon():
	is_transmitting_beacon = !is_transmitting_beacon
	beacon.set_arrow_visible(is_transmitting_beacon)

func disable_nexus_transmit():
	is_transmitting_beacon = false
	beacon.set_arrow_visible(is_transmitting_beacon)
