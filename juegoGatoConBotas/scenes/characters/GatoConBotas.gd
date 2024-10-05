extends CharacterBody2D
@onready var animation_player = $AnimationPlayer
var der = false
var izq = false
var atacando = false
var vidas = 5
signal perder_vida()

func _physics_process(delta: float) -> void:	
	if Input.is_anything_pressed():
		if Input.is_key_pressed(KEY_D) and Input.is_key_pressed(KEY_W):
			animation_player.play("AtacarDerecha")
			izq = false
			der = true
			atacando = true
		elif Input.is_key_pressed(KEY_A) and Input.is_key_pressed(KEY_W):
			animation_player.play("AtacarIzquierda")
			izq = true
			der = false
			atacando = true
		elif Input.is_key_pressed(KEY_D):
			animation_player.play("MoverDerecha")
			izq = false
			der = true
			atacando = false
		elif Input.is_key_pressed(KEY_A):
			animation_player.play("MoverIzquierda")
			izq = true
			der = false
			atacando = false
	else:
		animation_player.play("SacarEspada")


func RecibirGolpe(area: Area2D) -> void:
	if ((area.atacando_izq and (not atacando))) or  ((area.atacando_der) and (not atacando) or area.atacando_cen):
		perder_vida.emit()
		vidas -= 1
