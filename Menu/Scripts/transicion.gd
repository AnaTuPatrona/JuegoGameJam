extends CanvasLayer

@onready var anim = $AnimationPlayer

func cambiar_escena(path: String) -> void:
	layer = 5
	anim.play("Transicion")
	await(anim.animation_finished)
	get_tree().change_scene_to_file(path)
	anim.play("Transicion2")
	await(anim.animation_finished)
	layer = -1

func iniciar():
	layer = 5
	anim.play("inicio")
	await(anim.animation_finished)
	layer = -1

func _ready():
	layer = -1
	$AnimationPlayer.play("Transicion")

func game_over():
	layer = 5
	$AnimationPlayer.play_backwards("inicio")
	await(anim.animation_finished)
	get_tree().change_scene_to_file("res://general/escenas_generales/gameover2.tscn")
	$AnimationPlayer.play_backwards("inicio")
	await get_tree().create_timer(4.0).timeout
	cambiar_escena("res://Menu/Scenes/main_menu.tscn" )
