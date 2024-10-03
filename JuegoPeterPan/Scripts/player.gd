extends CharacterBody2D

func _process(delta: float) -> void:
	global_position.y = lerp(global_position.y,get_viewport().get_mouse_position().y,0.1)

func _ready():
	$AnimationPlayer.play("fly")
