extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Cancion.play_song()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_accept"):
		$Cancion.stop_song()
		Transicion.cambiar_escena("res://Menu/Scenes/main_menu.tscn")
		queue_free()
