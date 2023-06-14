extends Node
#--------------------------------------------------------------------------------------------------------------#
export var maxHealth = 1 setget setMaxHealth
var health = maxHealth setget setHealth

signal noHealth
signal healthUpdate(value)
signal maxHealthUpdate(value)
#--------------------------------------------------------------------------------------------------------------#
func _ready():
	self.health = maxHealth
#--------------------------------------------------------------------------------------------------------------#
func setHealth(value):
	health = value
	emit_signal("healthUpdate", health)
	if health <= 0:
		emit_signal("noHealth")
		
func setMaxHealth(value):
	maxHealth = value
	self.health = min(health, maxHealth)
	emit_signal("maxHealthUpdate", maxHealth)
#--------------------------------------------------------------------------------------------------------------#
