extends Node2D

var _decreaseSpeed:float
var _cooldown:float
var _musicId:float

var _velocity:float
var _incremet:float
var _decrement:float

var escene
@export var overBackground: PackedScene #Acá se carga o la escena de decisión o el minijuego de ritmo


func _ready() -> void:
	_createBaseEscene()
	
	
func _process(delta: float)->void:
	if(escene!=null):
		if(!escene.musicPlaying.is_connected(_musicOnPlay)):
			escene.musicPlaying.connect(_musicOnPlay)
		if(!escene.hasFailed.is_connected(_alFallar)):
			escene.hasFailed.connect(_alFallar)
	else:
		_byDefault()		

func _load_escene():
	escene=overBackground.instantiate()
	$"CanvasLayer/ContenedorNivel".add_child(escene)
	
func _createBaseEscene():
	_load_escene()
	#Las del juego general
	_decreaseSpeed=escene._decreaseSpeed
	_cooldown=escene._cooldown
	_musicId=escene._musicId
	#Las de la flecha
	_velocity=escene.getBaseArrowVeloity()
	_incremet=escene.getBaseLifeBarIncrement()
	_decrement=escene.getBaseLifeBarDecrement()		
	
func _byDefault():
	$"CanvasLayer/ContenedorNivel/Rinrin".playIdle()
	
func _musicOnPlay():
	$"CanvasLayer/ContenedorNivel/Rinrin".playDance()

func _alFallar():
	$"CanvasLayer/ContenedorNivel/Rinrin".playFail()
	
func miedoYHambreMode():
	escene.miedoYHambreLayer()
	
