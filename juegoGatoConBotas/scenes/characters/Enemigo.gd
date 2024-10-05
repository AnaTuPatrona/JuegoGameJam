extends Area2D

@onready var animation_player = $AnimationPlayer
@onready var timer = $Timer

var atacando_der = false
var atacando_izq = false
var izq = false
var der = false
var vidas = 5
var rnd = RandomNumberGenerator.new()
signal perder_vida()
var empezar=false
func _ready() -> void:
	animation_player.play("Normal")
	timer.start()

func _on_timer_timeout() -> void:
	if empezar:
		print("Ya empezo")
		var num = rnd.randi_range(0,10)
		if num<=5:
			izq = true
			der = false
		else:
			izq = false
			der = true
		if izq and not atacando_der:
			#print("Izquierda")
			if atacando_izq:
				num = rnd.randi_range(0,10)
				#if num <=5: #Volver a posicion normal
					#animation_player.play("Normal")
					#izq = false
					#der = false
					#atacando_izq = false
					#print("Volver")
				if num >=4: #Mover izq
					animation_player.play("MoverIzq")
					izq = true
					der = false
					atacando_izq = false
					atacando_der = false
					#print("Mover Izquierda")
			elif not atacando_izq:
				num = rnd.randi_range(0,10)
				if num <=5: #Volver a posicion normal
					animation_player.play("Normal")
					izq = false
					der = false
					atacando_izq = false
					atacando_der = false
					#print("Volver")
				if num >5: #Atacar izq
					animation_player.play("AtacarIzq")
					izq = true
					der = false
					atacando_izq = true
					atacando_der = false
					#print("Atacar Izquierda")
		elif der and not atacando_izq:
			#print("Derecha")
			if atacando_der:
				num = rnd.randi_range(0,10)
				#if num <=5: #Volver a posicion normal
					#animation_player.play("Normal")
					#izq = false
					#der = false
					#atacando_der = false
					#print("Volver")
				if num >=4: #Mover der
					animation_player.play("MoverDer")
					izq = false
					der = true
					atacando_der = false
					atacando_izq = false
					#print("Mover Derecha")
			elif not atacando_der:
				num = rnd.randi_range(0,10)
				if num <=5: #Volver a posicion normal
					animation_player.play("Normal")
					izq = false
					der = false
					atacando_der = false
					atacando_izq = false
					#print("Volver")
				if num >5: #Atacar der
					animation_player.play("AtacarDer")
					izq = false
					der = true
					atacando_der = true
					atacando_izq = false
					#print("Atacar Derecha")

func iniciar()->void:
	empezar = true

func RecibirGolpe(body):
	if (body.atacando) and (not atacando_der and not atacando_izq):
		perder_vida.emit()
		vidas -=1
