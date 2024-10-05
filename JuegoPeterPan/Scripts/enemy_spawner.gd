extends Marker2D

var bullet = preload("res://JuegoPeterPan/Scenes/bullet.tscn")

signal spawn_bullet(bullet, location)

func _on_timer_timeout() -> void:
	randomize()
	emit_signal("spawn_bullet", bullet, Vector2(1300, randi_range(0,720)))

func incvel() -> void:
	$Timer.wait_time = 1.0
	
func _on_scripter_incvel() -> void:
	$Timer.wait_time = 0.5
