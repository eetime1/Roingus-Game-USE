extends Node

	
func read(ourString: String) -> Variant:
	var wFile = FileAccess.open('./Data/GlobalData.json', FileAccess.READ)
	var jsoned = wFile.get_as_text()
	var json = JSON.new()
	json.parse(jsoned)
	var data_received = json.data
	wFile.close()
	
	if ourString == "all":
		return json
	return(data_received[ourString])

func write(ourString: String, ourData) -> void:
	var fuckyou = read('all')
	var quack = fuckyou.data
	print(quack, fuckyou.data[ourString], quack[ourString])
	quack[ourString] = ourData
	print(quack[ourString])
	
	var file = FileAccess.open('./Data/GlobalData.json', FileAccess.WRITE)
	print(fuckyou.data[ourString])
	
	var json_string = JSON.stringify(quack, "\t")
	file.store_string(json_string)
	file.close()
