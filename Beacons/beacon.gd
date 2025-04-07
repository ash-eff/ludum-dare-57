class_name Beacon
extends Node2D

var is_enabled: bool = true

@onready var arrow_sprite = $ArrowSprite

func set_arrow_visible(is_visible: bool):
	if !is_enabled:
		return
	arrow_sprite.visible = is_visible

func set_arrow_position(_position: Vector2):
	if !is_enabled:
		return
	arrow_sprite.global_position = _position
	
func set_arrow_rotation(_rotation):
	if !is_enabled:
		return
	arrow_sprite.rotation = _rotation

func set_beacon_disabled():
	set_arrow_visible(false)
	is_enabled = false
