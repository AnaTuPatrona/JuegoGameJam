extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite2D/AnimationPlayer.play("waves")
	global_position.x = 1011


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_scripter_escapeboat() -> void:
	$moveBoat.play("escape")
