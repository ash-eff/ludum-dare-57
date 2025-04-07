extends Control

@onready var docking_ui = $"Docking GUI"
@onready var docking_title = $"Docking GUI/MarginContainer/VBoxContainer/Title"

@onready var shop_ui = $"Shop GUI"

func _ready() -> void:
	pass

func show_docking_ui(title: String):
	docking_ui.visible = true
	docking_title.text = title

func cancel_dock():
	docking_ui.visible = false

func _on_enter_button_pressed() -> void:
	SignalBus.ship_docked.emit()
	docking_ui.visible = false
	shop_ui.visible = true

func on_loot_selected():
	await get_tree().create_timer(1).timeout
	on_close_gui()

func on_close_gui():
	queue_free()

func _on_close_button_pressed() -> void:
	SignalBus.ship_undocked.emit()
	on_close_gui()
