extends Node2D

var escene
@export var overBackground: PackedScene #Acá se carga o la escena de decisión o el minijuego de ritmo

func _ready() -> void:
	load_escene()
	
func _process(delta: float)->void:
	if(!escene.musicPlaying.is_connected(_musicOnPlay)):
		escene.musicPlaying.connect(_musicOnPlay)
	if(!escene.hasFailed.is_connected(_alFallar)):
		escene.hasFailed.connect(_alFallar)

func load_escene():
	escene=overBackground.instantiate()
	$"CanvasLayer/Contenedor nivel".add_child(escene)
	
func _musicOnPlay():
	$"CanvasLayer/Contenedor nivel/Rinrin".playDance()

func _alFallar():
	$"CanvasLayer/Contenedor nivel/Rinrin".playFail()

	
