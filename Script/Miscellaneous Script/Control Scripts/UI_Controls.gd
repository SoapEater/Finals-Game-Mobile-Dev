extends CanvasLayer

#--------------------------------------------------------------------------------------------------------------#
func openInventory():
	if Input.is_action_pressed("ui_inventory"):
		print("Inventory opened")
#--------------------------------------------------------------------------------------------------------------#
func _ready():
	openInventory()
#--------------------------------------------------------------------------------------------------------------#
func characterMovementSignal():
	pass
#--------------------------------------------------------------------------------------------------------------#
func _on_Settings_pressed():
	var nodeSetting = get_node("Settings")
	if nodeSetting.is_visible():
		nodeSetting.hide()
	else:
		nodeSetting.show()
		
	var newPauseState = not get_tree().paused
	get_tree().paused = newPauseState
#--------------------------------------------------------------------------------------------------------------#
func _on_TextureButton_pressed():
	Input.is_action_just_pressed("ui_attack")
	return
