extends Area2D
#--------------------------------------------------------------------------------------------------------------#
onready var entity = get_node(entityPath)
onready var timer = $Timer

export var entityPath : NodePath = ".."

var isInvincible = false setget setInvincibility

signal InvincibilityStart
signal InvincibilityEnded
#--------------------------------------------------------------------------------------------------------------#
func setInvincibility(value):
	isInvincible = value
	if isInvincible == true:
		emit_signal("InvincibilityStart")
	else:
		emit_signal("InvincibilityEnded")
#--------------------------------------------------------------------------------------------------------------#
func startInvincibility(duration):
	self.isInvincible = true
	timer.start(duration)
#--------------------------------------------------------------------------------------------------------------#
func _on_Timer_timeout():
	self.isInvincible = false
#--------------------------------------------------------------------------------------------------------------#
func _on_Hitbox_InvincibilityStart():
	set_deferred("monitoring", false)

func _on_Hitbox_InvincibilityEnded():
	set_deferred("monitoring", true)
#--------------------------------------------------------------------------------------------------------------#
