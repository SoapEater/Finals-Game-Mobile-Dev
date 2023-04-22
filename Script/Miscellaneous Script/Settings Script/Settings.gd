extends Control

func _ready():
	pass

func _on_Close_pressed():
	var getNode = get_node(".")
	
	getNode.hide()

func _on_TitleButton_pressed():
	get_tree().change_scene("res://Scene/Miscellaneous Scene/Menu Screen/Menu.tscn")
