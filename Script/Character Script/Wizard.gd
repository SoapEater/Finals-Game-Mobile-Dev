#--------------------------------------------------------------------------------------------------------------#
extends KinematicBody2D
#--------------------------------------------------------------------------------------------------------------#
#signals
signal healthUpdated(health)
signal kill()
#--------------------------------------------------------------------------------------------------------------#
#variables
var jumpPower : int
var gravity : int
var knockback = Vector2()
#--------------------------------------------------------------------------------------------------------------#
#variables for custom jump physics
export var speed = 100
export (float) var jumpPeak = .128
export (int) var jumpHeight = 128
export var maxHealth = 100
#--------------------------------------------------------------------------------------------------------------#
onready var animationPlayer = $Position2D/AnimationPlayer
onready var animationTree = $Position2D/AnimationTree
onready var position2D = $Position2D
onready var getSFXMelee = $SFX/MeleeSFX
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
	#--------------------------------------------------#
	#I hate switches if else are superior
#	match state:
#		MOVE:
#			characterMovement(delta)
#		ATTACK:
#			characterAttack()
	#--------------------------------------------------#
	if state == MOVE:
		characterMovement()
	elif state == ATTACK:
		characterAttack()
	#--------------------------------------------------#
#--------------------------------------------------------------------------------------------------------------#
func characterMovement():
	#--------------------------------------------------#
	if velocity.x == 0:
		stateMachine.travel("Idle")
	elif velocity.x != 0:
		stateMachine.travel("Walking")
	#--------------------------------------------------#
	if Input.is_action_pressed("ui_left"):
		velocity.x = -speed
		position2D.scale.x = -1
	elif Input.is_action_pressed("ui_right"):
		velocity.x = speed
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
	if Input.is_action_pressed("ui_attack") && is_on_floor():
		state = ATTACK
	#--------------------------------------------------#
#--------------------------------------------------------------------------------------------------------------#
func characterAttack():
	velocity.x = 0
	stateMachine.travel("Range Attack")
#--------------------------------------------------------------------------------------------------------------#
func characterAttackFinished():
	state = MOVE
#--------------------------------------------------------------------------------------------------------------#
func characterKnockback(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	knockback = move_and_slide(knockback)
#--------------------------------------------------------------------------------------------------------------#
func _on_Hitbox_area_entered(area):
	print("test")
