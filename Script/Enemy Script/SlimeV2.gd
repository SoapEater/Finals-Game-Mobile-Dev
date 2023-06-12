extends KinematicBody2D
#--------------------------------------------------------------------------------------------------------------#
onready var animationTree = $AnimationTree
onready var raycastEnvironment = $DetectEnvironment

var jumpPower : int
var gravity : int
var floors = Vector2(0, -1)
var velocity = Vector2()
var stateMachine

var isRaycastColliding = true

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
#--------------------------------------------------------------------------------------------------------------#
func _physics_process(delta):
	velocity.y += gravity
	turnDirectionOnDetect()
	moveCharacter(delta)
#--------------------------------------------------------------------------------------------------------------#
func moveCharacter(delta):
	if isRaycastColliding:
		velocity.x = speed
	else:
		velocity.x = -speed
	velocity = move_and_slide(velocity, floors)
#--------------------------------------------------------------------------------------------------------------#
func turnDirectionOnDetect():
	if not raycastEnvironment.is_colliding() and is_on_floor():
		isRaycastColliding = !isRaycastColliding
		scale.x = -scale.x
#--------------------------------------------------------------------------------------------------------------#
func beBouncedUpon(bouncer):
	if bouncer.has_method("bounce"):
		bouncer.bounce()
		queue_free()
#--------------------------------------------------------------------------------------------------------------#
