extends Node2D

@export var KeyObject: PackedScene

var pos: Array=[]
var _onPlay:bool=true
var _fade:bool=false

var _decreaseSpeed: float
var cooldown: float

func _init(decr: float=-0.12, cd: float=0.42) -> void:
	_decreaseSpeed=decr
	cooldown=cd #funciona muy bien con un cooldown de 0.42 y bpm de 100
	

func _ready():
	pos.append($CanvasLayer/ContenedorNotas/PressionAreas/PressionArea1.global_position.x)
	pos.append($CanvasLayer/ContenedorNotas/PressionAreas/PressionArea2.global_position.x)
	pos.append($CanvasLayer/ContenedorNotas/PressionAreas/PressionArea3.global_position.x)
	
	$RelojSpawn.wait_time=cooldown
	
func _process(delta: float) -> void:
	if _fade:
		if (!$CanvasLayer/ContenedorNotas/PressionAreas.modulate.a8<=0 && $RelojEliminar.is_stopped()):
			_drecreaseAlpha(5.0)
		elif($CanvasLayer/ContenedorNotas/PressionAreas.modulate.a8<=0):
			queue_free()					
	else:
		_updateLifeBar(_decreaseSpeed) #va quitandole vida a la barra constantemente		 	
	
func _spawn():
	var KeyInstance = KeyObject.instantiate()
	var p=position
	p.x=pos[randi()%3]
	KeyInstance.spawn(int(p.x)%3, p)	#Cambiar el módulo o cambiar los indices k identifican cada pos de flecha
	add_child(KeyInstance)	
	_updateLifeBar(KeyInstance.lifeChanged.connect(_updateLifeBar)) #Conexión con la señal k manda la flecha

func _updateLifeBar(increment: float):
	var newValue=$CanvasLayer/LifeBar.value+increment
	if(newValue>100):
		$CanvasLayer/LifeBar.value=100
	elif(newValue<0):
		$CanvasLayer/LifeBar.value=0	
	else:
		$CanvasLayer/LifeBar.value=newValue
		
func _drecreaseAlpha(decrease: float):
	$CanvasLayer/ContenedorNotas/PressionAreas.modulate.a8=$CanvasLayer/ContenedorNotas/PressionAreas.modulate.a8-decrease

func _on_timer_timeout() -> void:
	if(_onPlay):
		_spawn()


func _on_musica_finished() -> void:
	_onPlay=false
	_fade=true
	$RelojEliminar.start()


#func _on_reloj_eliminar_timeout() -> void:
	#queue_free()	
	
