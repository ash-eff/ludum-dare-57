extends Panel

@onready var loot_description = $VBoxContainer/LootDescription
var loot
var amount

func populate_loot(loot_data):
	# Access the 'item' and 'quantity' directly from the loot_data dictionary
	loot = loot_data["item"]
	amount = loot_data["quantity"]

	# Update the label with the loot and its quantity
	loot_description.text = loot.capitalize() + " x" + str(amount)

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		match loot:
			"medicine":
				SignalBus.add_health.emit(amount)
			"fuel":
				SignalBus.add_fuel.emit(amount)
			"food":
				SignalBus.add_food.emit(amount)
			"scrap":
				SignalBus.add_scrap.emit(amount)
			"survivor":
				SignalBus.add_morale.emit(amount)
		SignalBus.close_poi_gui.emit()
