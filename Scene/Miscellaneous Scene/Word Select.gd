extends Control

func _ready():
	Save.connect("dataLoaded", self, "_onDataLoaded")
	Save.LoadData()
	
	for i in range(1, 6):
		var buttonName = "world" + str(i)
		var button = $CanvasLayer.find_node(buttonName)
		button.connect("pressed", self, "connectButtonToWorld", [buttonName])
	
func _onDataLoaded(data):
	for button in $CanvasLayer.get_children():
		var worldName = button.name
		if data.has(worldName) and data[worldName] == true:
			button.visible = true
		else:
			button.visible = false

func connectButtonToWorld(buttonName):
	var buttonNumber := int(buttonName.replace("world", ""))
	var nextScenePath := "res://Scene/World Scene/World" + str(buttonNumber) + ".tscn"
	SceneTransition.SceneTransition(nextScenePath)
