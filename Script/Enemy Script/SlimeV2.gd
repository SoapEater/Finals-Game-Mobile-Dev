extends KinematicBody2D
#--------------------------------------------------------------------------------------------------------------#
onready var animationTree = $AnimationTree
onready var animationPlayer = $AnimationPlayer
onready var raycastEnvironment = $DetectEnvironment
onready var stats = $Stats
onready var resetBounced = $ResetBounced
onready var deathTimer = $DeathTimer

var jumpPower : int
var gravity : int
var floors = Vector2(0, -1)
var velocity = Vector2()
var stateMachine

var isRaycastColliding = true
var isBounced = false

export var speed = 100
export (float) var jumpPeak = .128
export (int) var jumpHeight = 128
#--------------------------------------------------------------------------------------------------------------#
func _ready():
	stateMachine = animationTree.get("parameters/playback")
	animationTree.active = true
	stateMachine.travel("Moving")
	
	gravity = (2*jumpHeight)/pow(jumpPeak,2)
	jumpPower = gravity * jumpPeak
	
	stats.connect("noHealth", self, "playDeathAnimation")
#--------------------------------------------------------------------------------------------------------------#
func _physics_process(delta):
	velocity.y += gravity
	
	turnDirectionOnDetect()	
	if isBounced == false:
		moveCharacter(delta)
	elif isBounced == true:
		velocity.x = 0
		
	velocity = move_and_slide(velocity, floors)
#--------------------------------------------------------------------------------------------------------------#
func moveCharacter(delta):
	if isRaycastColliding:
		velocity.x = speed
	else:
		velocity.x = -speed
#--------------------------------------------------------------------------------------------------------------#
func turnDirectionOnDetect():
	if not raycastEnvironment.is_colliding() and is_on_floor():
		isRaycastColliding = !isRaycastColliding
		scale.x = -scale.x
#--------------------------------------------------------------------------------------------------------------#
func beBouncedUpon(bouncer, damage):
	if bouncer.has_method("bounce"):
		bouncer.bounce()
		isBounced = true
		stats.health -=  damage
		
		resetBounced.start(.5)
		if stats.health != 0:
			stateMachine.travel("Bounced")
		elif stats.health == 0:
			stateMachine.travel("Death")
#--------------------------------------------------------------------------------------------------------------#
func playDeathAnimation():
	stateMachine.travel("Death")
	deathTimer.start(.52)
	
func _on_DeathTimer_timeout():
	queue_free()
#--------------------------------------------------------------------------------------------------------------#
func _on_ResetBounced_timeout():
	isBounced = false
	stateMachine.travel("Moving")
#--------------------------------------------------------------------------------------------------------------#
