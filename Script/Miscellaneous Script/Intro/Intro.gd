extends Control
#--------------------------------------------------------------------------------------------------------------#
onready var getMusic = get_node("/root/Music")
onready var test = get_node("/root/Music")
#--------------------------------------------------------------------------------------------------------------#
onready var AnimationPlayerVar = get_node("AnimationPlayer")
#--------------------------------------------------------------------------------------------------------------#
func _ready():	
	AnimationPlayerVar.play("Fade In")
	yield(get_tree().create_timer(6), "timeout")
	AnimationPlayerVar.play("Fade Out")
	yield(get_tree().create_timer(3), "timeout")
	get_tree().change_scene("res://Scene/Miscellaneous Scene/Menu Screen/Menu.tscn")
#--------------------------------------------------------------------------------------------------------------#
func _process(delta):
		
		Music.stop()
#--------------------------------------------------------------------------------------------------------------#
