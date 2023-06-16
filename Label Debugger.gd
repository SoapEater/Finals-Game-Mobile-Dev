extends CanvasLayer

onready var labelDebug = $LabelDebugger

func printDebug(value):
	labelDebug.text = value
	print(value)
