extends Control
@onready var john = $ProgressBar
@onready var john2 = $ProgressBar2

# Called when the node enters the scene tree for the first time.
var thread
var thread2
func _ready():
	thread = Thread.new()
	thread2 = Thread.new()

func _exit_tree() -> void:
	thread.wait_to_finish()
