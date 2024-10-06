extends Node

signal info1
signal showPeter
signal hidePeter
signal incvel
signal badending
signal escapeboat
signal goodending

var phase = 0

func _ready() -> void:
	ChoiceScene.opcion1.connect(on_option1)
	ChoiceScene.opcion2.connect(on_option2)

func _process(delta: float) -> void:
	pass


func _on_info_1_timeout() -> void:
	get_tree().paused = true
	$RetPeter.show_sprite()
	await(ChoiceScene.show_animation())
	await(ChoiceScene.display_text("¡El Capitán Garfio capturo a Wendy y los niños!"))
	await get_tree().create_timer(5.0).timeout
	await(ChoiceScene.display_text("¡Ayúdame a rescatarlos usando el puntero de tu mouse! ¡Yo te sigo!"))
	await get_tree().create_timer(5.0).timeout
	await(ChoiceScene.display_text("¡Evita las balas de cañón del Capitán Garfio o estaremos perdidos!"))
	await get_tree().create_timer(5.0).timeout
	get_tree().paused = false
	$RetPeter.hide_sprite()
	await(ChoiceScene.hide_animation())
	$phase2.start()

func _on_phase_2_timeout() -> void:
	phase = phase+1
	get_tree().paused = true
	$RetGarfio.show_sprite()
	await(ChoiceScene.show_animation())
	await(ChoiceScene.display_text("A esa velocidad nunca nos alcanzará ¡Ja Ja Ja!!"))
	await get_tree().create_timer(3.0).timeout
	$RetGarfio.hide_sprite()
	$RetPeter.show_sprite()
	await(ChoiceScene.display_text("¡Tenemos que ir más rápido!"))
	await get_tree().create_timer(3.0).timeout
	await(ChoiceScene.display_option("¿Aceleramos el ritmo?","Ir más rapido.", "Mejor lento pero seguro."))
	
func on_option1():
	await(ChoiceScene.display_text("¡Aceleremos el ritmo!"))
	await get_tree().create_timer(3.0).timeout
	$RetPeter.hide_sprite()
	get_tree().paused = false
	await(ChoiceScene.hide_animation())
	emit_signal("incvel")
	$goodending.start()

func on_option2():
	await(ChoiceScene.display_text("Vale, sigamos sin prisas."))
	await get_tree().create_timer(3.0).timeout
	$RetPeter.hide_sprite()
	get_tree().paused = false
	await(ChoiceScene.hide_animation())
	$badending.start()
	emit_signal("escapeboat")


func _on_badending_timeout() -> void:
	get_tree().paused = true
	$RetGarfio.show_sprite()
	await(ChoiceScene.show_animation())
	await(ChoiceScene.display_text("¡Finalmente lo estamos perdiendo!"))
	await get_tree().create_timer(3.0).timeout
	$RetGarfio.hide_sprite()
	$RetPeter.show_sprite()
	await(ChoiceScene.display_text("¡¡El bacalao se escapa!!"))
	await get_tree().create_timer(3.0).timeout
	await(ChoiceScene.display_text("¡¡Wendy!!"))
	await get_tree().create_timer(3.0).timeout
	await(ChoiceScene.display_text("¡¡Chicos!!"))
	await get_tree().create_timer(3.0).timeout
	$RetPeter.hide_sprite()
	await(ChoiceScene.display_text("El Capitán Garfio ha escapado."))
	await get_tree().create_timer(3.0).timeout
	get_tree().paused = false
	await(ChoiceScene.hide_animation())
	emit_signal("badending")


func _on_goodending_timeout() -> void:
	get_tree().paused = true
	$RetPeter.show_sprite()
	await(ChoiceScene.show_animation())
	await(ChoiceScene.display_text("¡Casi lo alcanzamos! ¡¡Sigue así!!"))
	await get_tree().create_timer(3.0).timeout
	$RetPeter.hide_sprite()
	await(ChoiceScene.display_text("Has alcanzado el barco del Capitán Garfio."))
	await get_tree().create_timer(3.0).timeout
	get_tree().paused = false
	ChoiceScene.hide_animation()
	emit_signal("goodending")
