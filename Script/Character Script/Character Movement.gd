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
onready var position2D = $Position2D
#--------------------------------------------------------------------------------------------------------------#
var floors = Vector2(0, -1)
var velocity = Vector2()
#--------------------------------------------------------------------------------------------------------------#
func _ready():
	gravity = (2*jumpHeight)/pow(jumpPeak,2)
	jumpPower = gravity * jumpPeak
#--------------------------------------------------------------------------------------------------------------#
func _physics_process(delta):
	#--------------------------------------------------#
	gravity()
	characterMovement(delta)
	animationPlayer()
	#--------------------------------------------------#
#--------------------------------------------------------------------------------------------------------------#
func characterMovement(delta):
	#--------------------------------------------------#
	if Input.is_action_pressed("ui_left"):
		velocity.x = -speed
	elif Input.is_action_pressed("ui_right"):
		velocity.x = speed
	else:
		velocity.x = 0
	#--------------------------------------------------#
	if Input.is_action_pressed("ui_left") && Input.is_action_pressed("ui_right"):
		velocity.x = 0
	#--------------------------------------------------#	
	if Input.is_action_pressed("ui_jump") && is_on_floor():
		velocity.y = -jumpPower
	#--------------------------------------------------#
	velocity = move_and_slide(velocity, floors)
	#--------------------------------------------------#
#--------------------------------------------------------------------------------------------------------------#
func gravity():
	velocity.y += gravity
#--------------------------------------------------------------------------------------------------------------#
func animationPlayer():
	#--------------------------------------------------#
	if velocity.x > 0:
		position2D.scale.x = 1
	elif velocity.x < 0:
		position2D.scale.x = -1
	#--------------------------------------------------#
	if is_on_floor() && velocity.x == 0:
		animationPlayer.play("Idle")
	elif is_on_floor() && velocity.x > 0:
		animationPlayer.play("Walking")
	elif is_on_floor() && velocity.x < 0:
		animationPlayer.play("Walking")
	#--------------------------------------------------#
#--------------------------------------------------------------------------------------------------------------#
