extends Node2D

var _decreaseSpeed:float=-0.15
var _cooldown:float=0.48
var _musicId:float=1

var _velocity:float=260
var _increment:float=10.2
var _decrement:float=-12.5

var escene
@export var overBackground: PackedScene #Acá se carga o la escena del minijuego de ritmo

var choice
@export var dialogBox: PackedScene #Acá se carga o el nodo de los textbox

var contrincante
@export var contrincantes:Array[PackedScene]

func _ready() -> void:
	contrincante=_nivel3(false)
	$CanvasLayer/ContenedorNivel/Contrincante.add_child(contrincante)
	
	
func _process(delta: float)->void:
	if(escene!=null):
		if(!escene.musicPlaying.is_connected(_musicOnPlay)):
			escene.musicPlaying.connect(_musicOnPlay)
			contrincante.playDance()
		if(!escene.hasFailed.is_connected(_alFallar)):
			escene.hasFailed.connect(_alFallar)
	else:
		#$CanvasLayer/ContenedorNivel/Contrincante.remove_child(contrincante)
		_byDefault()
		contrincante.playIdle()		

func _load_escene():
	escene=overBackground.instantiate()
	escene._decreaseSpeed=_decreaseSpeed
	escene._cooldown=_cooldown
	escene._musicId=_musicId
	escene._vel=_velocity
	escene._inc=_increment
	escene._dec=_decrement
	$"CanvasLayer/ContenedorNivel".add_child(escene)

#MODOS DE DECISIÓN

#correcta, pregunta 1
func baseEscene():
	_load_escene()

#incorrecta, pregunta 1
func lifePunishment():
	_decreaseSpeed=-0.32
	_decrement=-16.7
	_load_escene()

#correcta, pregunta 3
func risasYSonrisasMode():
	_decreaseSpeed=-0.15
	_velocity=320
	_cooldown=0.42
	_increment=15
	_decrement=-12.5
	_load_escene()
	escene.risasYSonrisasLayer()

#incorrecta, pregunta 2
func miedoYHambreMode():
	_decreaseSpeed=-0.23
	_velocity=380
	_cooldown=0.42
	_decrement=-14.5
	_increment=10.2
	_load_escene()
	escene.miedoYHambreLayer()
	
#correcta, pregunta 3
func inmortalMode():
	_velocity=680
	_cooldown=0.42	
	_decrement=0
	_increment=10.2
	_decreaseSpeed=-0.35
	_load_escene()
	escene.inmortalModeLayer()	
	
#incorrecta, pregunta 3
func blindMode():
	_decreaseSpeed=-0.18
	_velocity=380
	_cooldown=0.52	
	_decrement=-6
	_increment=18.5
	_load_escene()
	escene.activateBlindMode()
	escene.biggerPressAreaScale()
	escene.blindModeLayer()
	

#GENERAR NIVELES
func _nivel1(op:bool)->Node:
	_musicId=1
	if(op==true):
		baseEscene()
	else:
		lifePunishment()	
	return contrincantes[0].instantiate()
	
func _nivel2(op:bool)->Node:
	_musicId=2
	if(op==true):
		risasYSonrisasMode()
	else:
		miedoYHambreMode()	
	return contrincantes[1].instantiate()	
	
func _nivel3(op:bool)->Node:
	_musicId=3
	if(op==true):
		inmortalMode()
	else:
		blindMode()	
	return contrincantes[2].instantiate()		
	
func _byDefault():
	$"CanvasLayer/ContenedorNivel/Rinrin".playIdle()
	
func _musicOnPlay():
	$"CanvasLayer/ContenedorNivel/Rinrin".playDance()

func _alFallar():
	$"CanvasLayer/ContenedorNivel/Rinrin".playFail()
	
