extends Sprite2D

func show_sprite():
	$"../RetGarfio/AnimationPlayer2".play("show")

func hide_sprite():
	$"../RetGarfio/AnimationPlayer2".play_backwards("show")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
