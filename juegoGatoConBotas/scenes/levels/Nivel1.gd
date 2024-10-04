extends Node2D

@onready var character = $GatoConBotas
@onready var enemy = $Enemigo
@onready var timer = $Timer
const corazon_scn = preload("res://juegoGatoConBotas/scenes/extras/Vida.tscn")
const daño_character_scn = preload("res://juegoGatoConBotas/scenes/extras/Daño_character.tscn")
const daño_enemy_scn = preload("res://juegoGatoConBotas/scenes/extras/Daño_enemy.tscn")
var corazones_char = Array([], TYPE_OBJECT, "Area2D", null)
var corazones_enemy = Array([], TYPE_OBJECT, "Area2D", null)
var daño_character = daño_character_scn.instantiate()
var daño_enemy = daño_enemy_scn.instantiate()

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
		Transicion.cambiar_escena("res://general/assets_generales/EscenaGameOver.tscn")
	elif character.vidas == 0:
		character.queue_free()
	if enemy == null:
		print("Ganaste")
	elif enemy.vidas == 0:
		enemy.queue_free()


func PerderVidaChar() -> void:
	print("Has perdido una vida")
	daño_enemy.position.x = enemy.position.x - 45
	daño_enemy.position.y = enemy.position.y +90
	add_child(daño_enemy)
	timer.start(0.5)
	corazones_char[character.vidas-1].queue_free()


func PerderVidaEnemy() -> void:
	print("Enemigo perdio una vida")
	daño_character.position.x = character.position.x + 90
	daño_character.position.y = character.position.y -90
	add_child(daño_character)
	timer.start(0.5)
	corazones_enemy[enemy.vidas-1].queue_free()


func _on_timer_timeout() -> void:
	remove_child(daño_character)
	remove_child(daño_enemy)
