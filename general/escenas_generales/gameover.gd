extends Node2D

var _activated:bool=false

func _ready() -> void:
	$Sprite2D.modulate.a8=0

func _process(delta: float)->void:
	if(_activated && $Sprite2D.modulate.a8<255):
		_changeAlpha()
	
func _changeAlpha():
	$Sprite2D.modulate.a8+=10

func activate():
	_activated=true
