extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await(ChoiceScene.show_animation())
	await get_tree().create_timer(2.0).timeout
	ChoiceScene.display_text("Peter Pan y el Capitán Garfio tuvieron una batalla épica")
	await get_tree().create_timer(4.0).timeout
	ChoiceScene.display_text("Sin embargo el desenlace es una historia para otro día")
	await get_tree().create_timer(4.0).timeout
	ChoiceScene.display_text("Fin")
	await get_tree().create_timer(4.0).timeout
	await(ChoiceScene.hide_animation())
	Transicion.cambiar_escena("res://Menu/Scenes/main_menu.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
