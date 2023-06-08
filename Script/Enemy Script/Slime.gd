extends KinematicBody2D
#--------------------------------------------------------------------------------------------------------------#
onready var getAnimationTree = $Position2D/AnimationTree
onready var getRaycastEnvironment = $DetectEnvironmentCollision
onready var getPosition2D = $Position2D
onready var getHurtbox = $Hurtbox 

var jumpPower : int
var gravity : int

var floors = Vector2(0, -1)
var velocity = Vector2()
var stateMachine
var isRaycastColliding = true
var isPlayerInside = false

export var speed = 100
export (float) var jumpPeak = .128
export (int) var jumpHeight = 128
export var damage = 10

var state = MOVE

enum{
	MOVE,
	ATTACK
}
#--------------------------------------------------------------------------------------------------------------#
func _ready():
	stateMachine = getAnimationTree.get("parameters/playback")
	getAnimationTree.active = true
	
	gravity = (2*jumpHeight)/pow(jumpPeak,2)
	jumpPower = gravity * jumpPeak
#--------------------------------------------------------------------------------------------------------------#
func _physics_process(delta):
	velocity.y += gravity
	turnDirectionOnDetect()
	
	if state == MOVE:
		moveCharacter(delta)
	elif state == ATTACK:
		enemyAttack()
	
#--------------------------------------------------------------------------------------------------------------#
func moveCharacter(delta):
	
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
	getHurtbox.set_deferred("monitoring", true)

func endOfHit():
	getHurtbox.set_deferred("monitoring", false)

func startWalking():
	if isPlayerInside == false:
		state = MOVE
	else:
		stateMachine.travel("Attack")
#--------------------------------------------------------------------------------------------------------------#
func _on_PlayerDetector_body_exited(body):
	isPlayerInside = false
func _on_PlayerDetector_body_entered(body):
	isPlayerInside = true
	state = ATTACK
#--------------------------------------------------------------------------------------------------------------#
#--------------------------------------------------------------------------------------------------------------#
func enemyAttack():
	stateMachine.travel("Attack")
#--------------------------------------------------------------------------------------------------------------#
