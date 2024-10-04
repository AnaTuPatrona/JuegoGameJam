extends Sprite2D

var life: int = 3

var particles = preload("res://JuegoPeterPan/Scenes/explosion.tscn")

signal spawn_bullet_particles(particles,location)
signal reduce_life

func _process(delta: float) -> void:
	global_position.y = lerp(global_position.y,get_viewport().get_mouse_position().y,0.1)

func opacidad(newop: float) -> void:
	modulate.a = clamp(newop, 0.0,1.0)	

func _ready():
	$AnimationPlayer.play("fly")


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		emit_signal("reduce_life")
		emit_signal("spawn_bullet_particles", particles, area.global_position)
		area.get_parent().queue_free()
		$AnimationPlayer.play("hit")
		for i in range(3):
			opacidad(0.7)
			await get_tree().create_timer(0.2).timeout
			opacidad(1.0)
			await get_tree().create_timer(0.2).timeout
		$AnimationPlayer.play("hit2")
		await get_tree().create_timer(1.0).timeout
		$AnimationPlayer.play("fly")
		if life >= 0:
			life = life -1
