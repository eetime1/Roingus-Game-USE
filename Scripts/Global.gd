extends Node

var json = JSON.new()

func _ready() -> void:
	write("gemCount", "0")
	write("health", "100")
	write("roingusCount", "1")

func read(ourString: String, filePath: String = "./Data/GlobalData.json") -> Variant:
	var wFile = FileAccess.open(filePath, FileAccess.READ)
	var jsoned = wFile.get_as_text()
	json.parse(jsoned)
	var data_received = json.data
	wFile.close()
	
	if ourString == "all":
		return json
	return(data_received[ourString])

func write(ourString: String, ourData, filePath: String = "./Data/GlobalData.json") -> void:
	var fuckyou = read('all', filePath)
	var quack = fuckyou.data
	quack[ourString] = ourData
	
	var file = FileAccess.open(filePath, FileAccess.WRITE)
	
	var json_string = JSON.stringify(quack, "\t")
	file.store_string(json_string)
	file.close()
