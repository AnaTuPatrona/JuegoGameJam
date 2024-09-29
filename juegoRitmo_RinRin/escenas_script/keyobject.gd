extends Area2D

var velocity: float: #Es la variable que define que tan rápido va a bajar la flecha
	get: return velocity #getter
	set (increment): velocity=velocity+increment #setter

var _area: bool=false #Variable que indica si se está entro del área de presión o no
var selected_key=0 #Variable que guarda el índice de la flecha que se genera
var _presion: bool=false
var _exited: bool=false

var _increment: float
var _decrement: float
signal lifeChanged(size)

func _init(vel: float=320, incr: float=10.2, decr: float=-12.5) -> void:
	velocity=vel #favor que sea multiplo de 60
	_increment=incr
	_decrement=decr
	
func _process(delta: float) -> void:
	position.y+=velocity*delta #Con esta linea se aumenta la posición en y de la flecha con base a la velocidad y delta
			
	if _area: #Comprueba si se está en el área de presión o no	
		if Input.is_key_pressed(selected_key): #Si se presiona la tecla cuando toca
			#print("acertó") #poner a rinrin echandose los prohibidos al mandar esta señal
			_presion=true
			life_changes(_increment)
			queue_free()
			"""elif Input.is_key_pressed(!selected_key):
			print("hola")
			$EfectosSonido.play()"""
	
	elif _exited:		
		if ($Sprite2D.modulate.a8<=0):
			queue_free()	
		else:
			$Sprite2D.modulate.a8=$Sprite2D.modulate.a8-25 									

func spawn(key:int, pos:Vector2) -> void: #Función encargada de generar flechas
	position=pos
	match key:
		1:
			selected_key=KEY_A
			rotation_degrees=0 #solo por el placeholder k uso de momento. Cambiar cuando ya tenga una flecha de vdd
		2:
			selected_key=KEY_D 
			rotation_degrees=180 #solo por el placeholder k uso de momento. Cambiar cuando ya tenga una flecha de vdd
		0:
			selected_key=KEY_W 
			rotation_degrees=90 #solo por el placeholder k uso de momento. Cambiar cuando ya tenga una flecha de vdd

func life_changes(size:float):
	lifeChanged.emit(size)

func _on_area_entered(area: Area2D) -> void: #Cuando se entre al área de presión
	_area=true


func _on_area_exited(area: Area2D) -> void: #Cuando se salga del área de presión
	_area=false
	if(!_presion):
		life_changes(_decrement)
		_exited=true
		_presion=false
		#print("falló") #poner a rinrin cayendose
		#Poner para k se ponga la flecha como gris y ya no se tenga en cuenta			
