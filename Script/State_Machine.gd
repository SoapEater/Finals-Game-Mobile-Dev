extends Node
class_name StateMachine
#------------------------------------------------------------------------------------------#
var state = null setget setState
var previousState = null
var statesDictionary = {}

onready var parent = get_parent()
#------------------------------------------------------------------------------------------#
func _physics_process(delta):
	if state != null:
		var transition = getTransition(delta)
		stateLogic(delta)
		
		if transition != null:
			setState(transition)
#------------------------------------------------------------------------------------------#
func stateLogic(delta):
	pass

func getTransition(delta):
	return null

func enterState(newState, oldState):
	pass

func exitState(oldState, newState):
	pass

func setState(newState):
	previousState = state
	state = newState
	
	if previousState != null:
		exitState(previousState, newState)
	if newState != null:
		enterState(newState, previousState)

func addState(stateName):
	statesDictionary[stateName] = statesDictionary.size()
#------------------------------------------------------------------------------------------#
