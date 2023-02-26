extends KinematicBody2D

export var SPEED = 60
export var GRAVITY = 10
export var JUMP_POWER = -250
const FLOOR = Vector2(0, -1)

var velocity = Vector2()
var on_ground = false

onready var animation_player = $AnimationPlayer

func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
	else:
		velocity.x = 0

	if on_ground:
		if velocity.x == 0:
			animation_player.play("Idle")
		else:
			animation_player.play("Walking")
	else:
		if velocity.y < 0:
			animation_player.play("Jumping")

	if Input.is_action_pressed("ui_jump") and on_ground:
		velocity.y = JUMP_POWER
		on_ground = false

	velocity.y += GRAVITY
	velocity = move_and_slide(velocity, FLOOR)

	if is_on_floor():
		on_ground = true
