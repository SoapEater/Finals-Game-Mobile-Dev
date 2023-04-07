extends Node2D

func openInventory():
	if Input.is_action_pressed("ui_inventory"):
		print("Inventory opened")
		$TextureRect.visible = false
