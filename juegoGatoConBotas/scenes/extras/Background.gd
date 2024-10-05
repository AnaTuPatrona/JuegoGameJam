extends TextureRect

var back_palacio = preload("res://JuegoGatoConBotas/assets/background/Palacio.webp")
var back_cantina = preload("res://JuegoGatoConBotas/assets/background/Cantina.png")
var back_ruinas =  preload("res://JuegoGatoConBotas/assets/background/Ruinas.png")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if self.get_parent().name == "Nivel1":
		self.texture = back_palacio
		self.position.x = -395
		self.position.y = -340
		self.scale.x = 1.4
		self.scale.x = 1.4
	elif self.get_parent().name == "Nivel2":
		self.scale.x = 1
		self.scale.y = 1
		self.position.x = -100
		self.position.y = -127
		self.texture = back_cantina
	elif self.get_parent().name == "Nivel3":
		self.scale.x = 1
		self.scale.y = 1
		self.position.x = -100
		self.position.y = -260
		self.texture = back_ruinas
