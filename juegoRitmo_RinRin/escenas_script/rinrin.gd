extends Node2D


func _ready() -> void:
	playIdle()
	
func playIdle():
	$AnimatedSprite2D.play("idle")
	
func playDance():
	$AnimatedSprite2D.play("dance")	
	
func playFail():
	$AnimatedSprite2D.play("fail")
	
