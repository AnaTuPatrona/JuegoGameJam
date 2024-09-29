extends Node2D

@onready var character = $GatoConBotas
@onready var enemy = $Enemigo
const corazon_scn = preload("res://juegoGatoConBotas/scenes/GatoConBotas/Vida.tscn")
var corazones_char = Array([], TYPE_OBJECT, "Area2D", null)
var corazones_enemy = Array([], TYPE_OBJECT, "Area2D", null)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(character.vidas):
		var corazon = corazon_scn.instantiate()
		corazon.position.x = 50*(i+1)
		corazon.position.y = 50
		add_child(corazon)
		corazones_char.append(corazon)
	for i in range(enemy.vidas):
		var corazon = corazon_scn.instantiate()
		corazon.position.x = 1270 - 50*(i+1)
		corazon.position.y = 50
		add_child(corazon)
		corazones_enemy.append(corazon)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if character == null:
		print("Game Over")
	elif character.vidas == 0:
		character.queue_free()
	if enemy == null:
		print("Ganaste")
	elif enemy.vidas == 0:
		enemy.queue_free()


func PerderVidaChar() -> void:
	print("Has perdido una vida")
	corazones_char[character.vidas-1].queue_free()


func PerderVidaEnemy() -> void:
	print("Enemigo perdio una vida")
	corazones_enemy[enemy.vidas-1].queue_free()
