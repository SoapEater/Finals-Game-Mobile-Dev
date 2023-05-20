extends StateMachine
#------------------------------------------------------------------------------------------#
func stateLogic(delta):
	addState("attack")
	addState("walk")
	addState("idle")
	call_deferred("setState", statesDictionary.sleep)

func getTransition(delta):
	return null

func enterState(newState, oldState):
	pass

func exitState(oldState, newState):
	pass
#------------------------------------------------------------------------------------------#
