extends Node

signal info1
signal showPeter
signal hidePeter
signal incvel
signal badending
signal escapeboat
signal goodending
signal incyvel


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
	phase = phase+1
	get_tree().paused = true
	$RetGarfio.show_sprite()
	await(ChoiceScene.show_animation())
	await(ChoiceScene.display_text("A esa velocidad nunca nos alcanzará Ja Ja Ja!!"))
	await get_tree().create_timer(3.0).timeout
	$RetGarfio.hide_sprite()
	$RetPeter.show_sprite()
	await(ChoiceScene.display_text("Tenemos que ir más rápido!!"))
	await get_tree().create_timer(3.0).timeout
	await(ChoiceScene.display_option("¿Aceleramos el ritmo?","Ir más rapido", "Mejor lento pero seguro"))
	
func on_option1():
	await(ChoiceScene.display_text("¡¡Voy por ustedes chicos!!"))
	await get_tree().create_timer(3.0).timeout
	$RetPeter.hide_sprite()
	get_tree().paused = false
	await(ChoiceScene.hide_animation())
	emit_signal("incyvel")
	$badending2.start()
	

func on_option2():
	await(ChoiceScene.display_text("Vale, sigamos sin prisas!!"))
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
	await(ChoiceScene.display_text("Finalmente lo estamos perdiendo!"))
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
	await(ChoiceScene.display_text("El capitán Garfio ha escapado"))
	await get_tree().create_timer(3.0).timeout
	get_tree().paused = false
	await(ChoiceScene.hide_animation())
	emit_signal("badending")


func _on_goodending_timeout() -> void:
	get_tree().paused = true
	$RetPeter.show_sprite()
	await(ChoiceScene.show_animation())
	await(ChoiceScene.display_text("¡¡Casi lo alcanzamos!! ¡¡Sigue así!!"))
	await get_tree().create_timer(3.0).timeout
	$RetPeter.hide_sprite()
	await(ChoiceScene.display_text("Has alcanzado el barco del capitán Garfio"))
	await get_tree().create_timer(3.0).timeout
	get_tree().paused = false
	ChoiceScene.hide_animation()
	emit_signal("goodending")

func _on_phase_3_timeout() -> void:
	get_tree().paused = true
	$RetWendy.show_sprite()
	await(ChoiceScene.show_animation())
	await(ChoiceScene.display_text("¡¡Peter Ayudanos!!"))
	await get_tree().create_timer(3.0).timeout
	$RetWendy.hide_sprite()
	$RetPeter.show_sprite()
	await(ChoiceScene.display_text("¡¡Wendy!!"))
	await get_tree().create_timer(3.0).timeout
	await(ChoiceScene.display_text("¡¡Voy por ustedes!!"))
	await get_tree().create_timer(3.0).timeout
	$RetPeter.hide_sprite()
	$RetGarfio.show_sprite()
	await(ChoiceScene.display_text("Tendrás que pasar por encima mio si quieres escapar"))
	await get_tree().create_timer(3.0).timeout
	$RetGarfio.hide_sprite()
	$RetWendy.show_sprite()
	await(ChoiceScene.display_text("¡¡Ten cuidado Peter!!"))
	await get_tree().create_timer(3.0).timeout
	$RetWendy.hide_sprite()
	$RetPeter.show_sprite()
	await(ChoiceScene.display_text("Podría evadir la cubierta y salvarlos si hago un rodeo"))
	await get_tree().create_timer(3.0).timeout
	await(ChoiceScene.display_option("¿Que debería hacer?", "Salvar a los niños", "Enfrentarse a Garfio"))
	await get_tree().create_timer(3.0).timeout


func _on_badending_2_timeout() -> void:
	get_tree().paused = true
	$RetWendy.show_sprite()
	await(ChoiceScene.show_animation())
	await(ChoiceScene.display_text("¡¡Peter lo lograste!!"))
	await get_tree().create_timer(3.0).timeout
	$RetWendy.hide_sprite()
	$RetPeter.show_sprite()
	await(ChoiceScene.display_text("¡¡No hay nada que temer!!  ¡¡Huyamos del bacalao!!"))
	await get_tree().create_timer(3.0).timeout
	$RetPeter.hide_sprite()
	$RetWendy.show_sprite()
	await(ChoiceScene.display_text("¡¡Cuidadoo!!"))
	await get_tree().create_timer(3.0).timeout
	$RetWendy.hide_sprite()
	$RetGarfio.show_sprite()
	await(ChoiceScene.display_text("Ja Ja Ja!! De verdad pensaron que sería asi de fácil"))
	await get_tree().create_timer(3.0).timeout
	get_tree().paused = false
	emit_signal("badending")
	await(ChoiceScene.hide_animation())
