class_name Beacon
extends Node2D

@onready var arrow_sprite = $ArrowSprite

func set_arrow_visible(is_visible: bool):
	arrow_sprite.visible = is_visible

func set_arrow_position(_position: Vector2):
	arrow_sprite.global_position = _position
	
func set_arrow_rotation(_rotation):
	arrow_sprite.rotation = _rotation
