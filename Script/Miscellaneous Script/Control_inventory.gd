extends Control

func openInventory():
	if Input.is_action_pressed("ui_inventory"):
		print("Inventory opened")

func _process(delta):
	openInventory()
