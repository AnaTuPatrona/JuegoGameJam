extends Node2D

func _ready() -> void:
	$AnimatedSprite2D.flip_h=true
	
func playIdle():
	$AnimatedSprite2D.play("idle")
	
func playDance():
	$AnimatedSprite2D.play("dance")	
	
