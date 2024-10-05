extends Area2D

@onready var animation_player = $AnimationPlayer
@onready var timer = $Timer

var empezar = false
var atacando_der = false
var atacando_izq = false
var atacando_cen = false
var izq = false
var der = false
var centro = true
var vidas = 5
var rnd = RandomNumberGenerator.new()
signal perder_vida()

func _ready() -> void:
	animation_player.play("Normal")
	timer.start()

func _on_timer_timeout() -> void:
	if empezar:
		var num = rnd.randf_range(0,10)
		if num<=4:
			izq = true
			der = false
			centro = false
		elif num<=8:
			izq = false
			der = true
			centro = false
		else:
			izq = false
			der = false
			centro = true
		if izq and not atacando_der:
			#print("Izquierda")
			if atacando_izq:
				num = rnd.randf_range(0,10)
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
					centro = false
					atacando_izq = false
					atacando_der = false
					atacando_cen = false
					#print("Mover Izquierda")
			elif not atacando_izq:
				num = rnd.randf_range(0,10)
				if num <=5: #Volver a posicion normal
					animation_player.play("Normal")
					izq = false
					der = false
					centro = true
					atacando_izq = false
					atacando_der = false
					atacando_cen = false
					#print("Volver")
				if num >5: #Atacar izq
					animation_player.play("AtacarIzq")
					izq = true
					der = false
					centro = false
					atacando_izq = true
					atacando_der = false
					atacando_cen = false
					#print("Atacar Izquierda")
		elif der and not atacando_izq:
			#print("Derecha")
			if atacando_der:
				num = rnd.randf_range(0,10)
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
					centro = false
					atacando_der = false
					atacando_izq = false
					atacando_cen = false
					#print("Mover Derecha")
			elif not atacando_der:
				num = rnd.randf_range(0,10)
				if num <=5: #Volver a posicion normal
					animation_player.play("Normal")
					izq = false
					der = false
					centro = true
					atacando_der = false
					atacando_izq = false
					atacando_cen = false
					#print("Volver")
				if num >5: #Atacar der
					animation_player.play("AtacarDer")
					izq = false
					der = true
					centro = false
					atacando_der = true
					atacando_izq = false
					atacando_cen = false
					#print("Atacar Derecha")
		elif centro and not atacando_izq and not atacando_der:
			num = rnd.randf_range(0,10)
			if not atacando_cen:
				if num<=4:
					animation_player.play("AtacarCentro")
					izq = false
					der = false
					centro = true
					atacando_der = false
					atacando_izq = false
					atacando_cen = true
				elif num <=7:
					animation_player.play("MoverIzq")
					izq = true
					der = false
					centro = false
					atacando_izq = false
					atacando_der = false
					atacando_cen = false
				elif num <=10:
					animation_player.play("MoverDer")
					izq = false
					der = true
					centro = false
					atacando_der = false
					atacando_izq = false
					atacando_cen = false
			elif atacando_cen:
				num = rnd.randi_range(0,10)
				if num<=5:
					animation_player.play("Normal")
					izq = false
					der = false
					centro = true
					atacando_der = false
					atacando_izq = false
					atacando_cen = false

func iniciar()->void:
	empezar=true

func RecibirGolpe(body):
	if (body.atacando) and (not atacando_der and not atacando_izq and not atacando_cen):
		perder_vida.emit()
		vidas -=1
