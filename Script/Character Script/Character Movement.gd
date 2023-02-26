#--------------------------------------------------------------------------------------------------------------#
extends KinematicBody2D
#--------------------------------------------------------------------------------------------------------------#
#variables
export var speed : int
var jumpPower : int
var gravity : float
#--------------------------------------------------------------------------------------------------------------#
#variables for custom jump physics
export var jumpPeak : float
export var jumpHeight : int
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
	gravity(delta)
	characterMovement(delta)
	animationPlayer()
#--------------------------------------------------------------------------------------------------------------#
func characterMovement(delta):
	#--------------------------------------------------#
	if Input.is_action_pressed("ui_left"):
		velocity.x = -speed * delta
	elif Input.is_action_pressed("ui_right"):
		velocity.x = speed * delta
	else:
		velocity.x = 0
	#--------------------------------------------------#
	if Input.is_action_pressed("ui_left") && Input.is_action_pressed("ui_right"):
		velocity.x = 0
	#--------------------------------------------------#	
	if Input.is_action_pressed("ui_jump") && is_on_floor():
		velocity.y = -jumpPower * delta
	#--------------------------------------------------#
	velocity = move_and_slide(velocity * delta, floors)
	#--------------------------------------------------#
#--------------------------------------------------------------------------------------------------------------#
func gravity(delta):
	velocity.y += gravity * delta
#--------------------------------------------------------------------------------------------------------------#
func animationPlayer():
	if is_on_floor() && velocity.x == 0:
		animationPlayer.play("Idle")
	elif is_on_floor() && velocity.x > 0:
		position2D.scale.x = 1
		animationPlayer.play("Walking")
	elif is_on_floor() && velocity.x < 0:
		position2D.scale.x = -1
		animationPlayer.play("Walking")
#--------------------------------------------------------------------------------------------------------------#
