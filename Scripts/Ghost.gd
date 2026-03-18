extends CharacterBody2D

@onready var gamer = get_parent().isHoldingWhat

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	print(gamer)

func _on_gui_change_held() -> void:
	gamer = get_parent().isHoldingWhat
