extends Node2D

var _decreaseSpeed:float=-0.15
var _cooldown:float=0.48
var _musicId:float=2

var _velocity:float=260
var _increment:float=10.2
var _decrement:float=-12.5

var escene
@export var overBackground: PackedScene #Acá se carga o la escena del minijuego de ritmo

var choice
@export var dialogBox: PackedScene #Acá se carga o el nodo de los textbox

var contrincante: Node
@export var contrincantes:Array[PackedScene]


#PREGUNTAS

var _preguntas=["Rinrin Renacuajo, estás muy tieso y muy majo ¿Qué te dijo tu mamá cuando ibas a salir?",
"Renacuajo, moría por oirte cantar ¿Por qué me dejaste con la expectativa?",
"Oiga, Ranito ¿Usted sabe quién soy yo?"]

#RESPUESTAS

var _respuestas=[{true: "Que no me fuera.", false: "Que no volviera."},
{true: "Tengo sed y la ropa muy apretada.", false: "Tengo miedo y hambre."},
{true: "El pato tragón.", false: "El pato dragón."}]

signal sceneNull

func _init() -> void:
	ChoiceScene.opcion1.connect(_on_opcion1)
	ChoiceScene.opcion2.connect(_on_opcion2)	

func _ready() -> void:
	_onNull()
	pass
	
func _process(delta: float)->void:
	if(escene!=null):
		if(!escene.musicPlaying.is_connected(_musicOnPlay)):
			escene.musicPlaying.connect(_musicOnPlay)
			contrincante.playDance()
		if(!escene.hasFailed.is_connected(_alFallar)):
			escene.hasFailed.connect(_alFallar)
	else:
		_byDefault()
		if(contrincante!=null):
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
	changeMusicId()
	escene.onNull.connect(_onNull)

func _crearPregunta():
	ChoiceScene.set_questionV2(_preguntas[_musicId-1],_respuestas[_musicId-1])

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
	_increment=17.5
	_load_escene()
	escene.activateBlindMode()
	escene.biggerPressAreaScale()
	escene.blindModeLayer()
	

#GENERAR NIVELES
func _nivel1(op:bool)->void:
	if(op==true):
		baseEscene()
	else:
		lifePunishment()	
	
func _nivel2(op:bool)->void:
	if(op==true):
		risasYSonrisasMode()
	else:
		miedoYHambreMode()	
	
func _nivel3(op:bool)->void:
	if(op==true):
		inmortalMode()
	else:
		blindMode()		

func changeMusicId():
	_musicId+=1
	
func _byDefault():
	$"CanvasLayer/ContenedorNivel/Rinrin".playIdle()
	
func _musicOnPlay():
	$"CanvasLayer/ContenedorNivel/Rinrin".playDance()

func _alFallar():
	$"CanvasLayer/ContenedorNivel/Rinrin".playFail()
	
func _on_opcion1():
	await(ChoiceScene.hide_animation())
	if(_musicId==1):
		_nivel1(true)
	elif(_musicId==2):
		_nivel2(true)
	else:
		_nivel3(true)					

func _on_opcion2():
	await(ChoiceScene.hide_animation())
	if(_musicId==1):
		_nivel1(false)
	elif(_musicId==2):
		_nivel2(false)
	else:
		_nivel3(false)			
		
func _onNull():
	if(contrincante!=null):
		$CanvasLayer/ContenedorNivel/Contrincante.remove_child(contrincante)
	if(_musicId<4):
		contrincante=contrincantes[_musicId-1].instantiate()
		$CanvasLayer/ContenedorNivel/Contrincante.add_child(contrincante)
		_crearPregunta()
	else:
		ChoiceScene.show_animation()
		ChoiceScene.display_text("Despues del baile, Renacuajo ganó una victoria formidable. Así, Rinrin Renacuajo volvió a su casa saltando.")
		await get_tree().create_timer(3.2).timeout
		await(ChoiceScene.hide_animation())
		Transicion.cambiar_escena("res://Menu/Scenes/main_menu.tscn")
		queue_free()
