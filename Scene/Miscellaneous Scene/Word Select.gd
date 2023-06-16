extends Control

onready var label = $WorldSelect

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
			print("working")
		else:
			button.visible = false
			print("Not Working")

func connectButtonToWorld(buttonName):
	var buttonNumber := int(buttonName.replace("world", ""))
	var nextScenePath := "res://Scene/World Scene/World" + str(buttonNumber) + ".tscn"
	SceneTransition.SceneTransition(nextScenePath)
	LabelDebugger.printDebug(nextScenePath)


func _on_RESET_pressed():
	var newData = {
	"world1" : true,
	"world2" : false,
	"world3" : false,
	"world4" : false,
	"world5" : false,
	}
	Save.data = newData
	Save.getRelevantData()
	Save.LoadData()
