#--------------------------------------------------------------------------------------------------------------#
extends KinematicBody2D
#--------------------------------------------------------------------------------------------------------------#
#variables
var jumpPower : int
var gravity : int
#--------------------------------------------------------------------------------------------------------------#
#variables for custom jump physics
export var speed = 100
export (float) var jumpPeak = .128
export (int) var jumpHeight = 128
#--------------------------------------------------------------------------------------------------------------#
onready var animationPlayer = $Position2D/AnimationPlayer
onready var animationTree = $Position2D/AnimationTree
onready var position2D = $Position2D
#--------------------------------------------------------------------------------------------------------------#
var floors = Vector2(0, -1)
var velocity = Vector2()
var stateMachine
var state = MOVE
#--------------------------------------------------------------------------------------------------------------#
enum {
	MOVE,
	ATTACK
}
#--------------------------------------------------------------------------------------------------------------#
func _ready():
	gravity = (2*jumpHeight)/pow(jumpPeak,2)
	jumpPower = gravity * jumpPeak
	
	stateMachine = $Position2D/AnimationTree.get("parameters/playback")
	animationTree.active = true
#--------------------------------------------------------------------------------------------------------------#
func _physics_process(delta):
	#--------------------------------------------------#
	velocity = move_and_slide(velocity, floors)
	velocity.y += gravity
	characterMovement(delta)
	#--------------------------------------------------#
#--------------------------------------------------------------------------------------------------------------#
func characterMovement(delta):
	#--------------------------------------------------#
	if velocity.x == 0:
		stateMachine.travel("Idle")

	if velocity.x != 0:
		stateMachine.travel("Walking")

	if Input.is_action_pressed("ui_attack"):
		stateMachine.travel("Melee Attack")
	#--------------------------------------------------#
	if Input.is_action_pressed("ui_left"):
		velocity.x = -speed

		position2D.scale.x = -1
	elif Input.is_action_pressed("ui_right"):
		velocity.x = speed
#		
		position2D.scale.x = 1
	else:
		velocity.x = 0
	#--------------------------------------------------#
	if Input.is_action_pressed("ui_left") && Input.is_action_pressed("ui_right"):
		velocity.x = 0
	#--------------------------------------------------#	
	if Input.is_action_pressed("ui_jump") && is_on_floor():
		velocity.y = -jumpPower
	#--------------------------------------------------#
#--------------------------------------------------------------------------------------------------------------#
