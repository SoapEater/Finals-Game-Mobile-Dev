extends Node2D
#--------------------------------------------------------------------------------------------------------------#
var newData
#--------------------------------------------------------------------------------------------------------------#
func _ready():
	Save.connect("dataLoaded", self, "worldUpdate")
	Save.LoadData()
	
#--------------------------------------------------------------------------------------------------------------#
func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		var currentSceneNumber = int(get_tree().get_current_scene().get_filename().get_basename().get_basename())
		var nextSceneNumber = currentSceneNumber + 1
		var nextScenePath = "res://Scene/World Scene/World" + str(nextSceneNumber) + ".tscn"
		SceneTransition.SceneTransition(nextScenePath)
		
		if newData.has("world2") && nextSceneNumber == 2:
			newData["world2"] = true
			Save.data = newData
			Save.getRelevantData()
		elif newData.has("world3") && nextSceneNumber == 3:
			newData["world3"] = true
			Save.data = newData
			Save.getRelevantData()
		elif newData.has("world4") && nextSceneNumber == 4:
			newData["world4"] = true
			Save.data = newData
			Save.getRelevantData()
		elif newData.has("world5") && nextSceneNumber == 5:
			newData["world5"] = true
			Save.data = newData
			Save.getRelevantData()
			
#--------------------------------------------------------------------------------------------------------------#
func worldUpdate(data):
	newData = data
#--------------------------------------------------------------------------------------------------------------#
