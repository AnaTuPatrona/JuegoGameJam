extends Node2D

func _ready() -> void:
	$BgMusic.play()


func _process(delta: float) -> void:
	pass


func _on_bullet_spawner_spawn_bullet(bullet: Variant, location: Variant) -> void:
	var bullet_instance = bullet.instantiate()
	add_child(bullet_instance)
	bullet_instance.global_position = location


func _on_player_spawn_bullet_particles(particles: Variant, location: Variant) -> void:
	var explosion_instance = particles.instantiate()
	add_child(explosion_instance)
	explosion_instance.global_position = location
	
