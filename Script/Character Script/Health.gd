extends Control
#--------------------------------------------------------------------------------------------------------------#
onready var hearts = 5 setget setHeart
onready var maxHearts = 5 setget setMaxHeart
onready var UiHeartsFull = $HeartsFull
onready var UiHeartsEmpty = $HeartsEmpty

#--------------------------------------------------------------------------------------------------------------#
func setHeart(value):
	hearts = clamp(value, 0, maxHearts)
	if UiHeartsFull != null:
		UiHeartsFull.rect_size.x = hearts * 48
	
func setMaxHeart(value):
	maxHearts = max(value, 1)
	self.hearts = min(hearts, maxHearts)
	if UiHeartsFull != null:
		UiHeartsEmpty.rect_size.x = maxHearts * 48
#--------------------------------------------------------------------------------------------------------------#
func _ready():
	PlayerStats.connect("healthUpdate", self, "setHeart")
	PlayerStats.connect("maxHealthUpdate", self, "setMaxHeart")
	
	self.hearts = PlayerStats.health
	self.maxHearts = PlayerStats.maxHealth
#--------------------------------------------------------------------------------------------------------------#
