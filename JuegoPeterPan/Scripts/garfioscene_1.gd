extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(4.0).timeout
	await(ChoiceScene.show_animation())
	await(ChoiceScene.display_text("Continuará..."))
	await get_tree().create_timer(7.0).timeout
	await(ChoiceScene.hide_animation())
	Transicion.cambiar_escena("res://Menu/Scenes/main_menu.tscn")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
