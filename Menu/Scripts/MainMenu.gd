extends Control

func _ready() -> void:
	pass 


func _process(delta: float) -> void:
	pass


func _on_libro_1_pressed() -> void:
	pass # Replace with function body.


func _on_libro_3_pressed() -> void:
	Transicion.cambiar_escena("res://juegoGatoConBotas/scenes/GatoConBotas/Escenario.tscn")


func _on_libro_2_pressed() -> void:
	Transicion.cambiar_escena("res://juegoRitmo_RinRin/escenas_script/escenary.tscn")
