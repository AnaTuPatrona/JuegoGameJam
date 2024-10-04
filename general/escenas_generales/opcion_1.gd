extends Button


func _ready() -> void:
	pass 

func opacidad(newop: float) -> void:
	modulate.a = clamp(newop, 0.0,1.0)	


func _is_pressed():
	return button_pressed

func brillo(factor: float) -> void:
	modulate.r = clamp(modulate.r * factor, 0.0, 2.0)
	modulate.g = clamp(modulate.g * factor, 0.0, 2.0)
	modulate.b = clamp(modulate.b * factor, 0.0, 2.0)

func restaurar_brillo():
	modulate = Color(1.0, 1.0, 1.0, modulate.a)

func controlop() -> void:
	if(is_hovered()):
		opacidad(0.7)
	else:
		opacidad(1.0)


func controlbril() -> void:
	if(_is_pressed()):
		brillo(1.5)
	else:
		restaurar_brillo()


func _process(delta: float) -> void:
	controlbril()
	controlop()
