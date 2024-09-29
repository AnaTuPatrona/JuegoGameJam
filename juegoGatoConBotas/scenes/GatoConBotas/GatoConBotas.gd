extends CharacterBody2D
@onready var animation_player = $AnimationPlayer

var der = false
var izq = false
var atacando = false
var vidas = 5
signal perder_vida()

func _physics_process(delta: float) -> void:	
	if Input.is_anything_pressed():
		if Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_up"):
			animation_player.play("AtacarDerecha")
			izq = false
			der = true
			atacando = true
		elif Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_up"):
			animation_player.play("AtacarIzquierda")
			izq = true
			der = false
			atacando = true
		elif Input.is_action_pressed("ui_right"):
			animation_player.play("MoverDerecha")
			izq = false
			der = true
			atacando = false
		elif Input.is_action_pressed("ui_left"):
			animation_player.play("MoverIzquierda")
			izq = true
			der = false
			atacando = false
	else:
		animation_player.play("SacarEspada")


func RecibirGolpe(area: Area2D) -> void:
	if ((area.atacando_izq and (not atacando))) or  ((area.atacando_der) and (not atacando)):
		print("Golpeado")
		perder_vida.emit()
		vidas -= 1
