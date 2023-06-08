extends CanvasLayer
#--------------------------------------------------------------------------------------------------------------#
func _on_TextureButton_pressed():
	var nodeSetting = get_node("Settings")
	
	if nodeSetting.is_visible():
		nodeSetting.hide()
	else:
		nodeSetting.show()
	
	var newPauseState = not get_tree().paused
	get_tree().paused = newPauseState
#--------------------------------------------------------------------------------------------------------------#
