extends Sprite2D

var speed = 200

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	global_position.x -= speed * delta
	
	if global_position.x < -20:
		queue_free()
