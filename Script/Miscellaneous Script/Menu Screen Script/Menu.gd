extends Control
#--------------------------------------------------------------------------------------------------------------#
func _ready():
	Music.play()
	
func _on_Start_released():
	SceneTransition.SceneTransition("res://Scene/Miscellaneous Scene/Word Select.tscn")
#--------------------------------------------------------------------------------------------------------------#
func _on_Exit_released():
	get_tree().quit()
#--------------------------------------------------------------------------------------------------------------#
