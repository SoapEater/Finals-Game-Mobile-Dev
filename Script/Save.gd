extends Node2D

const SAVE_DIR = "user://saves/"
var savePath = SAVE_DIR + "save.dat"
signal dataLoaded(data)

var data = {
	"world1" : true,
	"world2" : false,
	"world3" : false,
	"world4" : false,
	"world5" : false,
	}
	
func _on_Save_pressed():
	getRelevantData()

func _on_Load_pressed():
	LoadData()

func getRelevantData():
	var dir = Directory.new()
	if !dir.dir_exists(SAVE_DIR):
		dir.make_dir_recursive(SAVE_DIR)
	
	var file = File.new()
	var error = file.open(savePath, File.WRITE)
	if error == OK:
		file.store_var(data)
		file.close()
		print("Saved Successfully")

func LoadData():
	var file = File.new()
	if file.file_exists(savePath):
		var error = file.open(savePath, File.READ)
		if error == OK:
			var LoadedData = file.get_var()
			file.close()
			print("Loaded Successfully")
			print(LoadedData)
			emit_signal("dataLoaded", LoadedData)


func _on_Reset_pressed():
	var newData = {
	"world1" : true,
	"world2" : false,
	"world3" : false,
	"world4" : false,
	"world5" : false,
	}
	data = newData
	getRelevantData()
