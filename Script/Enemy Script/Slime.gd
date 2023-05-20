extends KinematicBody2D
#--------------------------------------------------------------------------------------------------------------#
onready var getAnimationTree = $Position2D/AnimationTree
onready var getRaycastEnvironment = $DetectEnvironmentCollision
onready var getPosition2D = $Position2D

var jumpPower : int
var gravity : int

var floors = Vector2(0, -1)
var velocity = Vector2()
var stateMachine
var isRaycastColliding = true
var isAttacking

export var speed = 100
export (float) var jumpPeak = .128
export (int) var jumpHeight = 128
#--------------------------------------------------------------------------------------------------------------#
func _ready():
	stateMachine = getAnimationTree.get("parameters/playback")
	
	getAnimationTree.active = true
#	stateMachine.travel("Walking")
	$Position2D/AnimationPlayer.play("Walking")
	
	gravity = (2*jumpHeight)/pow(jumpPeak,2)
	jumpPower = gravity * jumpPeak
#--------------------------------------------------------------------------------------------------------------#
func _physics_process(delta):
	velocity.y += gravity
	
	moveCharacter()
	turnDirectionOnDetect()
	
#--------------------------------------------------------------------------------------------------------------#
func moveCharacter():
	if isRaycastColliding:
		velocity.x = speed
	else:
		velocity.x = -speed
		
	velocity = move_and_slide(velocity, floors)
#--------------------------------------------------------------------------------------------------------------#
func turnDirectionOnDetect():
	if not getRaycastEnvironment.is_colliding() and is_on_floor():
		isRaycastColliding = !isRaycastColliding
		scale.x = -scale.x
#--------------------------------------------------------------------------------------------------------------#
func hit():
	$DamageArea.monitoring = true
func endOfHit():
	$DamageArea.monitoring = false
	
func startWalking():
	$Position2D/AnimationPlayer.play("Walking")
#--------------------------------------------------------------------------------------------------------------#
func _on_PlayerDetector_body_entered(body):
	stateMachine.travel("Attack") #This doesn't work
	$Position2D/AnimationPlayer.play("Attack") #Does work

func _on_DamageArea_body_entered(body):
	get_tree().reload_current_scene()
	print("player hit")
#--------------------------------------------------------------------------------------------------------------#
