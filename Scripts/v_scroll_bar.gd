extends VScrollBar


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(value, " ", $ClipContainer/VBoxContainer.position, " ",$ClipContainer/VBoxContainer.size)
	$ClipContainer/VBoxContainer.position.y = -(value / max_value * size.y)
	pass
