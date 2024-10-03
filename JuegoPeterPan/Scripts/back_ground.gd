extends ParallaxBackground

@export var speed: int
var mov = 0

func _set_scroll_offset(offset: Vector2) -> void:
	scroll_offset = offset

func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	mov += speed * delta
	set_scroll_offset(Vector2(-mov,0))
