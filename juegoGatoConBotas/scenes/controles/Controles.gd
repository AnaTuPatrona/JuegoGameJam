extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Transicion.iniciar()

func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_accept"):
		Transicion.cambiar_escena("res://juegoGatoConBotas/scenes/levels/Nivel1.tscn")
