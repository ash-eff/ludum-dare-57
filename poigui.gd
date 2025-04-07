extends Control

@onready var docking_ui = $"Docking GUI"
@onready var docking_title = $"Docking GUI/MarginContainer/VBoxContainer/Title"
@onready var docking_description = $"Docking GUI/MarginContainer/VBoxContainer/Description"

@onready var dice_ui = $"Dice GUI"
@onready var dice_label = $"Dice GUI/MarginContainer/VBoxContainer/Dice Label"
@onready var dice_outcome_label = $"Dice GUI/MarginContainer/VBoxContainer/Outcome LAbel"
@onready var dice_roll_button = $"Dice GUI/MarginContainer/VBoxContainer/RollDiceButton"
@onready var accept_outcome_button = $"Dice GUI/MarginContainer/VBoxContainer/AcceptOutcomeButton"

@onready var room_ui = $"Room GUI"
@onready var room_card_one = $"Room GUI/MarginContainer/VBoxContainer/HBoxContainer/RoomCard"
@onready var room_card_two = $"Room GUI/MarginContainer/VBoxContainer/HBoxContainer/RoomCard2"
@onready var room_card_three = $"Room GUI/MarginContainer/VBoxContainer/HBoxContainer/RoomCard3"

@onready var outcome_ui = $"Outcome GUI"
@onready var outcome_description = $"Outcome GUI/MarginContainer/VBoxContainer/Title"
@onready var loot_card_one = $"Outcome GUI/MarginContainer/VBoxContainer/HBoxContainer/LootCard"
@onready var loot_card_two = $"Outcome GUI/MarginContainer/VBoxContainer/HBoxContainer/LootCard2"
@onready var loot_card_three = $"Outcome GUI/MarginContainer/VBoxContainer/HBoxContainer/LootCard3"

var timer
var rand_dice_value
var first_room: RoomResource
var second_room: RoomResource
var third_room: RoomResource

func _ready() -> void:
	SignalBus.close_poi_gui.connect(on_close_gui)

func show_docking_ui(title: String, description: String, _first_room: RoomResource, 
	_second_room: RoomResource, _third_room: RoomResource):
	docking_ui.visible = true
	docking_title.text = title
	docking_description.text = description
	first_room = _first_room
	second_room = _second_room
	third_room = _third_room
	
func show_dice_ui():
	docking_ui.visible = false
	dice_ui.visible = true
	
func show_room_ui():
	room_ui.visible = true
	room_card_one.populate_room_data(first_room)
	room_card_two.populate_room_data(second_room)
	room_card_three.populate_room_data(third_room)

func show_outcome_ui(room: RoomResource):
	room_ui.visible = false
	outcome_ui.visible = true
	var room_data_array = room.get_room_data()
	if room_data_array.size() > 0:
		outcome_description.text = room_data_array.pick_random()
	else:
		outcome_description.text = "No data available."
	loot_card_one.populate_loot(room.loot_table.return_loot())
	loot_card_two.populate_loot(room.loot_table.return_loot())
	loot_card_three.populate_loot(room.loot_table.return_loot())		
	
func roll_dice():
	dice_roll_button.visible = false
	accept_outcome_button.visible = true
	accept_outcome_button.disabled = true
	rand_dice_value = randi_range(1, 12)
	timer = Timer.new()
	timer.wait_time = .1
	timer.one_shot = false
	timer.timeout.connect(_on_roll_tick)
	add_child(timer)
	timer.start()
	var timer2 = Timer.new()
	timer2.wait_time = 3
	timer2.one_shot = true
	timer2.timeout.connect(_on_stop_roll)
	add_child(timer2)
	timer2.start()
	
func _on_roll_tick():
	dice_label.text = str(randi_range(1, 12))
	
func _on_stop_roll():
	timer.stop()
	dice_label.text = str(rand_dice_value)
	var outcome_text = ''
	match rand_dice_value:
		1:
			outcome_text = "You lose 1 morale and flee back to your ship."
			SignalBus.lose_morale.emit(1)
		2:
			outcome_text = "Navigating the wreckage proved to be difficult. You lose 1 fuel."
			SignalBus.lose_fuel.emit(1)
		3, 4, 6, 7, 8, 11:
			outcome_text = "You successfully dock with the ship."
		5:
			outcome_text = "You lose 1 health injuring yourself cutting through the lock."
			SignalBus.lose_health.emit(1)
		9:
			outcome_text = "Docking with the wreckage did not go smoothly. You lose 1 scrap to repairs."
			SignalBus.lose_scrap.emit(1)
		10:
			outcome_text = "You sprung a booby trap on the docking airlock and take 1 damage."
			SignalBus.lose_scrap.emit(1)
		12:
			outcome_text = "You lose 1 scrap and 1 fuel after colliding with lose bedris while docking."
			SignalBus.lose_scrap.emit(1)
			SignalBus.lose_fuel.emit(1)
	
	dice_outcome_label.text = outcome_text
	accept_outcome_button.disabled = false

func _on_enter_button_pressed() -> void:
	show_dice_ui()

func _on_leave_button_pressed() -> void:
	pass # Replace with function body.

func _on_roll_dice_button_pressed() -> void:
	roll_dice()

func _on_accept_outcome_button_pressed() -> void:
	dice_ui.visible = false
	show_room_ui()

func _on_room_card_one_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		show_outcome_ui(first_room)

func _on_room_card_2_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		show_outcome_ui(second_room)

func _on_room_card_3_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		show_outcome_ui(third_room)

func on_close_gui():
	queue_free()
