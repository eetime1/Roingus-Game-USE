extends Control

func _ready():
	## This code writes to the file correctly
	#var dict = {"Shawn": "shimy"}
	#var file = FileAccess.open('./configs/test.txt', FileAccess.WRITE)
	#
	#var json_string = JSON.stringify(dict, "\t")
	#file.store_string(json_string)
	#file.close()
	#
	## This code reads the file correctly
	#var wFile = FileAccess.open('./configs/test.txt', FileAccess.READ)
	#var jsoned = wFile.get_as_text()
	#var json = JSON.new()
	#var error = json.parse(jsoned)
	#
	#var data_received = json.data
	#print(data_received.Shawn)
	pass
	
func _quit_button():
	get_tree().quit()
	pass
