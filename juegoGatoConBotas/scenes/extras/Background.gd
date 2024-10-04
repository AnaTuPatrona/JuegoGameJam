extends StaticBody2D

@onready var Sprite = $Sprite2D
var back_palacio = preload("res://JuegoGatoConBotas/assets/background/Palacio.webp")
var back_cantina = preload("res://JuegoGatoConBotas/assets/background/Cantina.png")
var back_ruinas =  preload("res://JuegoGatoConBotas/assets/background/Ruinas.png")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if self.get_parent().name == "Nivel1":
		Sprite.texture = back_palacio
		Sprite.position.x = 30
		Sprite.position.y = 15
		Sprite.scale.x = 1.434
		Sprite.scale.x = 1.445
	elif self.get_parent().name == "Nivel2":
		Sprite.scale.x = 1
		Sprite.scale.y = 1
		Sprite.position.x = 100
		Sprite.position.y = 120
		Sprite.texture = back_cantina
	else:
		Sprite.scale.x = 1
		Sprite.scale.y = 1
		Sprite.position.x = 100
		Sprite.position.y = 80
		Sprite.texture = back_ruinas
