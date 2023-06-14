extends CanvasLayer
#--------------------------------------------------------------------------------------------------------------#
onready var animationPlayer = $AnimationPlayer
#--------------------------------------------------------------------------------------------------------------#
func SceneTransition(path):
	animationPlayer.play("TransitionEffect")
	yield(animationPlayer, "animation_finished")
	get_tree().change_scene(path)
	animationPlayer.play_backwards("TransitionEffect")
#--------------------------------------------------------------------------------------------------------------#
