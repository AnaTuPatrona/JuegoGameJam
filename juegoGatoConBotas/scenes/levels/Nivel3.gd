extends Node2D

@onready var character = $GatoConBotas
@onready var enemy = $Ogro
@onready var timer = $Timer
@export var GameOver: PackedScene

var loseScreen

const corazon_scn = preload("res://juegoGatoConBotas/scenes/extras/Vida.tscn")
const daño_character_scn = preload("res://juegoGatoConBotas/scenes/extras/Daño_character.tscn")
const daño_enemy_scn = preload("res://juegoGatoConBotas/scenes/extras/Daño_enemy.tscn")
var corazones_char = Array([], TYPE_OBJECT, "Area2D", null)
var corazones_enemy = Array([], TYPE_OBJECT, "Area2D", null)
var daño_character = daño_character_scn.instantiate()
var daño_enemy = daño_enemy_scn.instantiate()


func _init() -> void:
	ChoiceScene.opcion1.connect(_on_opcion1)
	ChoiceScene.opcion2.connect(_on_opcion2)	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await ChoiceScene.show_animation()
	get_tree().paused = true
	ChoiceScene.display_text("¿Te atreves a venir a desafiarme?")
	await get_tree().create_timer(4).timeout
	await crearPregunta("Si me vences, este reino sera tuyo y de tu amo ¿estás preparado?","Más que nunca.","A pelear.")
	await get_tree().create_timer(10).timeout
	gui()
	enemy.iniciar()
	
func gui()-> void:
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
		#loseScreen=GameOver.instantiate()
		#add_sibling(loseScreen)
		#loseScreen.activate()
		Transicion.game_over()
		queue_free()
	elif character.vidas == 0:
		character.queue_free()
	if enemy == null:
		$Cancion.stop_song()
		Transicion.cambiar_escena("res://juegoGatoConBotas/scenes/levels/Final.tscn")
		queue_free()
	elif enemy.vidas == 0:
		enemy.queue_free()

func PerderVidaChar() -> void:
	daño_enemy.position.x = enemy.position.x
	daño_enemy.position.y = enemy.position.y +90
	add_child(daño_enemy)
	timer.start(0.5)
	corazones_char[character.vidas-1].queue_free()


func PerderVidaEnemy() -> void:
	daño_character.position.x = character.position.x + 90
	daño_character.position.y = character.position.y -90
	add_child(daño_character)
	timer.start(0.5)
	corazones_enemy[enemy.vidas-1].queue_free()


func _on_timer_timeout() -> void:
	remove_child(daño_character)
	remove_child(daño_enemy)

func crearPregunta(pregunta: String, respuesta1: String, respuesta2: String)->void:
	$Cancion.play_song()
	ChoiceScene.display_option(pregunta,respuesta1,respuesta2)
	
func _on_opcion1()->void:
	ChoiceScene.display_text("Aghh")
	$Sonido.play()
	await get_tree().create_timer(7.5).timeout
	$Sonido.stop()
	await(ChoiceScene.hide_animation())
	get_tree().paused = false

func _on_opcion2()->void:
	ChoiceScene.display_text("Ohh")
	await get_tree().create_timer(2).timeout
	ChoiceScene.display_text("Veo que te crees mucho")
	await get_tree().create_timer(4).timeout
	await(ChoiceScene.hide_animation())
	enemy.timer.wait_time = 0.6
	get_tree().paused = false
