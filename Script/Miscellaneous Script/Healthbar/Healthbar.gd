extends Control
#--------------------------------------------------------------------------------------------------------------#
onready var healthBar = $TextureProgress

export var greenHealthBar = Color.green
export var yellowHealthBar = Color.yellow
export var redHealthBar = Color.red
#--------------------------------------------------------------------------------------------------------------#
export (float, 0, 1, 0.05) var yellowZone = 0.5
export (float, 0, 1, 0.05) var redZone = 0.2
#--------------------------------------------------------------------------------------------------------------#
func onHealthUpdated(health, amount):
	healthBar.value = health
#--------------------------------------------------------------------------------------------------------------#
func onMaxHealthUpdated(maxHealth):
	healthBar.max_value = maxHealth

func colorAssign(health):
	if health < healthBar.max_value * redZone:
		healthBar.tint_progress = redHealthBar
		
	elif health < healthBar.max_value * yellowZone:
		healthBar.tint_progress = yellowHealthBar
	
	else:
		healthBar.tint_progress = greenHealthBar
#--------------------------------------------------------------------------------------------------------------#
