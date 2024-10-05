extends Node2D

@export var KeyObject: PackedScene
@export var GameOver: PackedScene

var loseScreen

signal musicPlaying()
signal hasFailed()
signal onNull

var pos: Array=[]
var _onPlay:bool=true #Guarda si se está reproduciendo la música
var _fade:bool=false #Guarda si se está desvaneciendo el nivel

var _gameOver:bool=false

#Variables de la barra de vida y más

var _decreaseSpeed: float: #Velocidad a la que disminuye la barrita de vida
	get: return _decreaseSpeed
	set (value): _decreaseSpeed=value
	
var _cooldown: float: #Frecuencia de spawn de las notas
	get: return _cooldown
	set (value): _cooldown=value
		
var _musicId: int: #Nombre/Indice de la canción
	get: return _musicId
	set (value): _musicId=value

var _musicDirection #Dirección de donde se reproduce la música

#Variables de las flechas

var _vel: float:
	set(value): _vel=value
	
var _inc: float:
	set(value): _inc=value
	
var _dec: float:
	set(value): _dec=value

var _blindMode:bool=false

func _init(decr: float=-0.15, cd: float=0.48, id="1") -> void:
	_decreaseSpeed=decr
	_cooldown=cd #funciona muy bien con un cooldown de 0.42 y bpm de 100
	_musicId=int(id)
	

func _ready():
	_musicDirection=load("res://juegoRitmo_RinRin/assets/"+str(_musicId)+".mp3") #acá se carga la dirección
	_load_music(_musicDirection)
	pos.append($CanvasLayer/ContenedorNotas/PressionAreas/PressionArea1.global_position.x)
	pos.append($CanvasLayer/ContenedorNotas/PressionAreas/PressionArea2.global_position.x)
	pos.append($CanvasLayer/ContenedorNotas/PressionAreas/PressionArea3.global_position.x)
	
	$CanvasLayer/FiltroInmortal/ColorLayer.pause()
	$CanvasLayer/FiltroBlind/ColorLayer.pause()
	
	$RelojSpawn.wait_time=_cooldown
	
func _process(delta: float) -> void:
	if($CanvasLayer/ContenedorNotas/Controles.modulate.a8>0):
		$CanvasLayer/ContenedorNotas/Controles.modulate.a8-=1.2
	else:
		$CanvasLayer/ContenedorNotas/Controles.visible=false
		
	if (_fade && !_gameOver):
		if (!$CanvasLayer/ContenedorNotas/PressionAreas.modulate.a8<=0 && $RelojEliminar.is_stopped()):
			_drecreaseAlpha(5.0)
		elif($CanvasLayer/ContenedorNotas/PressionAreas.modulate.a8<=0):
			await(onNull.emit())
			queue_free()					
	elif(!_gameOver):
		_updateLifeBar(_decreaseSpeed) #va quitandole vida a la barra constantemente
		
	elif(_gameOver):
		loseScreen=GameOver.instantiate()
		add_sibling(loseScreen)
		loseScreen.activate()
		queue_free()
					 	
	
func _spawn():
	var KeyInstance = KeyObject.instantiate()
	KeyInstance._velocity=_vel
	KeyInstance._increment=_inc
	KeyInstance._decrement=_dec
	var p=position
	p.x=pos[randi()%3]
	KeyInstance.spawn(int(p.x)%3, p)	#Cambiar el módulo o cambiar los indices k identifican cada pos de flecha
	add_child(KeyInstance)
	
	if(_blindMode): #Si está el modo ciego
		blindMode(KeyInstance)
				
	_updateLifeBar(KeyInstance.lifeChanged.connect(_updateLifeBar)) #Conexión con la señal k manda la flecha
	if(!KeyInstance.failingNote.is_connected(_missedNote)):
		KeyInstance.failingNote.connect(_missedNote)

func _missedNote():
	hasFailed.emit()

func _updateLifeBar(increment: float):
	var newValue=$CanvasLayer/LifeBar.value+increment
	if(newValue>100):
		$CanvasLayer/LifeBar.value=100
	elif(newValue<=0):
		$CanvasLayer/LifeBar.value=0
		_gameOver=true
		$RelojSpawn.stop()
	else:
		$CanvasLayer/LifeBar.value=newValue
		
func _drecreaseAlpha(decrease: float):
	$CanvasLayer/ContenedorNotas/PressionAreas.modulate.a8=$CanvasLayer/ContenedorNotas/PressionAreas.modulate.a8-decrease

func _load_music(music: AudioStream):
	$Musica.stream=music
	$Musica.play()

func miedoYHambreLayer(): #Modo de juego
		$CanvasLayer/FiltroMiedoYHambre.visible=true
		
func risasYSonrisasLayer(): #Modo de juego
		$CanvasLayer/FiltroRisasYSonrisas.visible=true
		
func inmortalModeLayer(): #Modo de juego
		$CanvasLayer/FiltroInmortal.visible=true
		$CanvasLayer/FiltroInmortal/ColorLayer.play()						

func blindModeLayer(): #Modo de juego
		$CanvasLayer/FiltroBlind.visible=true
		$CanvasLayer/FiltroBlind/ColorLayer.play()	

func activateBlindMode():
	_blindMode=true

func blindMode(flecha: Area2D):
	flecha._blindMode=true

func biggerPressAreaScale():
	$CanvasLayer/ContenedorNotas/PressionAreas/PressionArea1.scale=$CanvasLayer/ContenedorNotas/PressionAreas/PressionArea1.scale*1.4
	$CanvasLayer/ContenedorNotas/PressionAreas/PressionArea2.scale=$CanvasLayer/ContenedorNotas/PressionAreas/PressionArea2.scale*1.4
	$CanvasLayer/ContenedorNotas/PressionAreas/PressionArea3.scale=$CanvasLayer/ContenedorNotas/PressionAreas/PressionArea3.scale*1.4

func _on_timer_timeout() -> void: #De RelojSpawn
	if(_onPlay):
		musicPlaying.emit()
		_spawn()

func _on_musica_finished() -> void:
	_onPlay=false
	_fade=true
	$RelojEliminar.start()
