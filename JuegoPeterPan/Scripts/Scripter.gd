extends Node

signal info1
signal showPeter
signal hidePeter

func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	pass


func _on_info_1_timeout() -> void:
	get_tree().paused = true
	$RetPeter.show_sprite()
	await(ChoiceScene.show_animation())
	await(ChoiceScene.display_text("El capitan Garfio capturo a Wendy y los niños!!"))
	await get_tree().create_timer(5.0).timeout
	await(ChoiceScene.display_text("Ayudame a rescatarlos usando el puntero de tu mouse!! yo te sigo!!"))
	await get_tree().create_timer(5.0).timeout
	await(ChoiceScene.display_text("Evita las balas de cañon del capitan Garfio o estaremos perdidos!!"))
	await get_tree().create_timer(5.0).timeout
	get_tree().paused = false
	$RetPeter.hide_sprite()
	await(ChoiceScene.hide_animation())
	$phase2.start()

func _on_phase_2_timeout() -> void:
	get_tree().paused = true
	$RetGarfio.show_sprite()
	await(ChoiceScene.show_animation())
	await(ChoiceScene.display_text("A esa velocidad nunca nos alcanzará Ja Ja Ja!!"))
	await get_tree().create_timer(5.0).timeout
	$RetGarfio.hide_sprite()
	$RetPeter.show_sprite()
	await(ChoiceScene.display_text("Tenemos que ir más rápido!!"))
	await get_tree().create_timer(5.0).timeout
	await(ChoiceScene.display_option("¿Aceleramos el ritmo?","Ir más rapido", "Mejor lento pero seguro"))
