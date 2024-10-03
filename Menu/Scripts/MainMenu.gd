extends Control

@onready var bg_music = $"Bg Music"
@onready var sound_selected = $Select
@onready var sound_hover = $Hover

func _ready() -> void:
	bg_music.play()
	Transicion.iniciar()


func _process(delta: float) -> void:
	pass


func _on_libro_1_pressed() -> void:
	sound_selected.play()
	Transicion.cambiar_escena("res://JuegoPeterPan/Scenes/main_scene.tscn")



func _on_libro_3_pressed() -> void:
	sound_selected.play()
	Transicion.cambiar_escena("res://juegoGatoConBotas/scenes/GatoConBotas/Escenario.tscn")


func _on_libro_2_pressed() -> void:
	sound_selected.play()
	Transicion.cambiar_escena("res://juegoRitmo_RinRin/escenas_script/escenary.tscn")


func _on_libro_2_mouse_entered() -> void:
	sound_hover.play()


func _on_libro_3_mouse_entered() -> void:
	sound_hover.play()


func _on_libro_1_mouse_entered() -> void:
	sound_hover.play()
