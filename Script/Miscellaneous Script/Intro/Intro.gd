extends Control
#--------------------------------------------------------------------------------------------------------------#
onready var getMusic = get_node("/root/Music")
onready var test = get_node("/root/Music")
#--------------------------------------------------------------------------------------------------------------#
onready var AnimationPlayerVar = get_node("AnimationPlayer")
#--------------------------------------------------------------------------------------------------------------#
var newData

func _ready():	
	Save.connect("dataLoaded", self, "getData")
	Save.LoadData()
	print(newData)
	
	
	AnimationPlayerVar.play("Fade In")
	yield(get_tree().create_timer(6), "timeout")
	AnimationPlayerVar.play("Fade Out")
	yield(get_tree().create_timer(3), "timeout")
	SceneTransition.SceneTransition("res://Scene/Miscellaneous Scene/Menu Screen/Menu.tscn")
#--------------------------------------------------------------------------------------------------------------#
func getData(value):
	newData = value
	
func _process(delta):
		Music.stop()
#--------------------------------------------------------------------------------------------------------------#
