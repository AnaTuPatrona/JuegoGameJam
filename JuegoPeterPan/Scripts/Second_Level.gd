extends Node2D

func _ready() -> void:
	$BgMusic.play()
	$BulletSpawner.incvel()

var rng = RandomNumberGenerator.new()
var difvel: int = 200


func _init() -> void:
	pass

func _process(delta: float) -> void:
	difvel = rng.randf_range(200, 700)


func _on_bullet_spawner_spawn_bullet(bullet: Variant, location: Variant) -> void:
	var bullet_instance = bullet.instantiate()
	bullet_instance.speed = difvel
	add_child(bullet_instance)
	bullet_instance.global_position = location


func _on_player_spawn_bullet_particles(particles: Variant, location: Variant) -> void:
	var explosion_instance = particles.instantiate()
	add_child(explosion_instance)
	explosion_instance.global_position = location
	


func _on_player_game_over() -> void:
	$Scream.play()
	Transicion.game_over()


func _on_scripter_incvel() -> void:
	difvel = 700
	$CanvasLayer/BackGround.set_speed(300)


func _on_scripter_badending() -> void:
	Transicion.game_over()


func _on_scripter_goodending() -> void:
	Transicion.cambiar_escena("res://JuegoPeterPan/Scenes/Second Level.tscn")
