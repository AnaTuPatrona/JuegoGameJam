extends Node2D

var _activated:bool=false

func _ready() -> void:
	$imagen.modulate.a8=0

func _process(delta: float)->void:
	if(_activated && $imagen.modulate.a8<255):
		_changeAlpha()
		if($imagen.modulate.a8>=255):
			await get_tree().create_timer(1.7).timeout
			await (Transicion.cambiar_escena("res://Menu/Scenes/main_menu.tscn"))
			queue_free()
	
func _changeAlpha():
	$imagen.modulate.a8+=10

func activate():
	_activated=true
