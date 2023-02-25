#--------------------------------------------------------------------------------------------------------------#
extends KinematicBody2D
#--------------------------------------------------------------------------------------------------------------#
#variables
export var speed = 60
export var jumpPower = 250
export var gravity = 10
#--------------------------------------------------------------------------------------------------------------#
var onGrounds = false
var floors = Vector2(0, -1)
var velocity = Vector2()
#--------------------------------------------------------------------------------------------------------------#
func _physics_process(delta):
	grounded()
	gravity()
	characterMovement()
#--------------------------------------------------------------------------------------------------------------#
func characterMovement():
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
	if Input.is_action_pressed("ui_jump"):
		if onGrounds == true:
			velocity.y = -jumpPower
			onGrounds = false
	#--------------------------------------------------#
	velocity = move_and_slide(velocity, floors)
	#--------------------------------------------------#
#--------------------------------------------------------------------------------------------------------------#
func gravity():
	velocity.y += gravity
#--------------------------------------------------------------------------------------------------------------#
func grounded():
	if is_on_floor():
		onGrounds = true
	else:
		onGrounds = false
#--------------------------------------------------------------------------------------------------------------#
