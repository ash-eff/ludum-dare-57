class_name LootTableResource
extends Resource

@export var loot_table = [
	{"item":"medicine", "weight":0},
	{"item":"fuel", "weight":0},
	{"item":"food", "weight":0},
	{"item":"scrap", "weight":0},
	{"item":"survivor", "weight":1},
]

func return_loot() -> Dictionary:
	var rng = RandomNumberGenerator.new()
	var weights = []
	var items = []
	
	for item in loot_table:
		weights.append(item["weight"])
		items.append(item["item"])

	var dropped_loot = items[rng.rand_weighted(weights)]

	var quantity = calculate_quantity(dropped_loot)
	return {"item": dropped_loot, "quantity": quantity}

func calculate_quantity(item: String) -> int:
	var selected_item = null
	for loot_item in loot_table:
		if loot_item["item"] == item:
			selected_item = loot_item
			break
	
	if selected_item:
		if item != "survivor":
			var roll = randi_range(0, 100)
			if roll < selected_item["weight"]:  # Higher weight = more likely to get 2 or 3
				return 2
			else:
				return 1
		else:
			return 1
	return 1
