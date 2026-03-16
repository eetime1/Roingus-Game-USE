extends Label


func _process(_delta) -> void:
	text = str(Global.read("gemCount"))
	pass
