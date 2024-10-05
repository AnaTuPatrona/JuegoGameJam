extends AudioStreamPlayer

var fading_entrada = false
var fading_salida = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if fading_entrada:
		volume_db+=30*delta
		if volume_db >=0:
			volume_db=-10
			fading_entrada=false
	if fading_salida:
		volume_db-=30*delta
		if volume_db <=-60:
			fading_entrada=false
			stop()
func play_song()->void:
	volume_db=-60
	play()
	fading_entrada=true

func stop_song():
	volume_db=-10
	fading_salida = true
