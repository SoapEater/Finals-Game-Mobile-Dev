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

export var bounceDamage = 1
export (float) var invincibilityDuration = 1
#--------------------------------------------------------------------------------------------------------------#
const bounceVelocity = -250
#--------------------------------------------------------------------------------------------------------------#
onready var animationPlayer = $Position2D/AnimationPlayer
onready var animationTree = $Position2D/AnimationTree
onready var position2D = $Position2D
onready var getSFXJump = $SFX/JumpSFX
onready var bounceRaycasts = $BounceRaycasts
onready var hitbox = $Hitbox
onready var flashTimer = $InvincibiltyFlashTimer
onready var positionRestart = $PositionInDeath
#--------------------------------------------------------------------------------------------------------------#
var floors = Vector2(0, -1)
var velocity = Vector2()
var stateMachine
var state = MOVE
var stats = PlayerStats

signal playerDied
#--------------------------------------------------------------------------------------------------------------#
enum {
	MOVE,
	ATTACK
}
#--------------------------------------------------------------------------------------------------------------#
func _ready():
	stats.connect("noHealth", self, "playDeathAnimation")
	gravity = (2*jumpHeight)/pow(jumpPeak,2)
	jumpPower = gravity * jumpPeak
	
	positionRestart.position = position
	
	stateMachine = $Position2D/AnimationTree.get("parameters/playback")
	animationTree.active = true
#--------------------------------------------------------------------------------------------------------------#
func _physics_process(delta):
	#--------------------------------------------------#
	velocity.y += gravity
	checkBounce(delta)
	velocity = move_and_slide(velocity, floors)
	#--------------------------------------------------#
	if state == MOVE:
		characterMovement(delta)
	#--------------------------------------------------#
#--------------------------------------------------------------------------------------------------------------#
func characterMovement(delta):
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
		getSFXJump.play()
	#--------------------------------------------------#
#--------------------------------------------------------------------------------------------------------------#
func checkBounce(delta):
	if velocity.y > 0:
		for raycast in bounceRaycasts.get_children():
			raycast.cast_to = Vector2.DOWN * velocity.y * delta + Vector2.DOWN
			raycast.force_raycast_update()
			if raycast.is_colliding() && raycast.get_collision_normal().y < -0.8:
				velocity.y = (raycast.get_collision_point() - raycast.global_position - Vector2.DOWN).y / delta
				raycast.get_collider().entity.call_deferred("beBouncedUpon", self, bounceDamage)
				break
#--------------------------------------------------------------------------------------------------------------#
func bounce(bounce_Velocity = bounceVelocity):
	velocity.y = bounce_Velocity
#--------------------------------------------------------------------------------------------------------------#
func _on_Hitbox_area_entered(area):
	stats.health -= area.damage
	animationPlayer.play("Damage")
	animationPlayer.queue("InvulnerabilityFlash")
	flashTimer.start(invincibilityDuration)
	hitbox.startInvincibility(invincibilityDuration)
#--------------------------------------------------------------------------------------------------------------#
func _on_InvincibiltyFlashTimer_timeout():
	animationPlayer.play("RESET")
#--------------------------------------------------------------------------------------------------------------#
func playDeathAnimation():
	global_position = positionRestart.position
	stats.health = 5
#--------------------------------------------------------------------------------------------------------------#
