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
