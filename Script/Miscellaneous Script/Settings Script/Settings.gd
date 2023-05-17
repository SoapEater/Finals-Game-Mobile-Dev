extends Control

onready var getMusicNode = get_node("/root/Music")
onready var getSFXNode = get_node("/root/Sfx")

func _ready():
	pass

func _on_Close_pressed():
	var getNode = get_node(".")
	getNode.hide()

func _on_TitleButton_pressed():
	get_tree().change_scene("res://Scene/Miscellaneous Scene/Menu Screen/Menu.tscn")
	var newPauseState = not get_tree().paused
	get_tree().paused = newPauseState

func _on_MusicSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)
	if value == -30:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), true)
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), false)
		
func _on_SFXSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value)
	if value == -30:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX"), true)
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX"), false)

func _on_Button_pressed():
	if getMusicNode.playing:
		getMusicNode.stop()
	else:
		getMusicNode.play()
	
	


func _on_Button2_pressed():
	if getSFXNode.playing:
		getSFXNode.stop()
	else:
		getSFXNode.play()
		
	Input.vibrate_handheld(500)
