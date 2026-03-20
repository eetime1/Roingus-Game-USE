extends Node

var json = JSON.new()
var mushroomsCost = {"path":25, "turret":50, "wall":100, "heal":150, "spore": 200, "delete": -25}
var data = {"gemCount": 50000, "health": 200, "roingusCount": 0, "fireIndex": 0, "winningRoinguses": 25}
var currentLevel = 0
var globalPosition = Vector2(0,0)
#func _ready() -> void:
	#write("gemCount", 300)
	#write("health", 200)
	#write("roingusCount", 1)
	#write("fireIndex", 0)

func read(ourString: String, filePath: String = "./Data/configs/config.json") -> Variant:
	var wFile = FileAccess.open(filePath, FileAccess.READ)
	var jsoned = wFile.get_as_text()
	json.parse(jsoned)
	var data_received = json.data
	wFile.close()
	
	if ourString == "all":
		return json
	return(data_received[ourString])
	
func write(ourString: String, ourData, filePath: String = "./Data/configs/config.json") -> void:
	var fuckyou = read('all', filePath)
	var quack = fuckyou.data
	quack[ourString] = ourData
	
	var file = FileAccess.open(filePath, FileAccess.WRITE)
	
	var json_string = JSON.stringify(quack, "\t")
	file.store_string(json_string)
	file.close()
	
func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		Global.write("currentScreen", DisplayServer.window_get_current_screen(), "./Data/configs/config.json")
		get_tree().quit()
