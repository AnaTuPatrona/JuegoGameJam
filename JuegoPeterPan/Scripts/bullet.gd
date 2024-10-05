extends Sprite2D

var speed = 200
var yspeed = 0

func _ready() -> void:
	for i in range(100):
		yspeed = yspeed * (-1)
		await get_tree().create_timer(0.6).timeout


func _process(delta: float) -> void:
	global_position.y = lerp(global_position.y, global_position.y + yspeed, 1.0)
	global_position.x -= speed * delta
	rotation_degrees = rotation_degrees - speed*delta
	
	if global_position.x < -20:
		queue_free()
