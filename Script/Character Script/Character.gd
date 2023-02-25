#--------------------------------------------------------------------------------------------------------------#
extends KinematicBody2D
#--------------------------------------------------------------------------------------------------------------#
export var SPEED = 60
export var GRAVITY = 10
export var JUMP_POWER = -250
const FLOOR = Vector2(0, -1)
#--------------------------------------------------------------------------------------------------------------#
var velocity = Vector2()
var on_ground = false
#--------------------------------------------------------------------------------------------------------------#
func _physics_process(delta):
	jump_grounded()
	#--------------------------------------------------#
#--------------------------------------------------------------------------------------------------------------#
func jump_grounded():
	#--------------------------------------------------#
	if on_ground == true:
		velocity.y = JUMP_POWER
		on_ground = false	
	velocity.y += GRAVITY
	if is_on_floor():
		on_ground = true
	else:
		on_ground = false
	#--------------------------------------------------#
func character_movement():
	#--------------------------------------------------#
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_just_pressed("ui_jump"):
		jump_grounded()
	else:
		velocity.x = 0
	velocity = move_and_slide(velocity, FLOOR)
	#--------------------------------------------------#
#--------------------------------------------------------------------------------------------------------------#
