extends Control

#FAVOR NO TOCAR
@onready var label = $CanvasLayer/BoxContainer/VBoxContainer/HBoxContainer2/RichTextLabel
@onready var button1 = $CanvasLayer/BoxContainer/VBoxContainer/HBoxContainer/opcion1
@onready var button2 = $CanvasLayer/BoxContainer/VBoxContainer/HBoxContainer/opcion2
@onready var container = $CanvasLayer/BoxContainer/VBoxContainer/HBoxContainer
@onready var anim = $CanvasLayer/AnimationPlayer
@onready var box = $CanvasLayer/BoxContainer
signal opcion1
signal opcion2

func show_animation() -> void: #animacion de entrada
	anim.play("show")
	await(anim.animation_finished)
	box.visible = true
	 
func hide_animation() -> void: #animacion de salida
	box.visible = false
	anim.play_backwards("show")
	await(anim.animation_finished)

func display_text(textin: String) -> void: #funcion para mostrar texto, solo recibe el texto como parametro
	container.visible = false
	label.text = ("[center]" + textin + "[/center]")
	anim.play("display_text" )
	await(anim.animation_finished)
	
func display_option(textin: String, option1: String, option2: String) -> void: #funcion para mostrar panel de desiciones, texto y ambas opciones como parametro
	button1.text = option1
	button2.text = option2
	container.visible = true
	label.text = ("[center]" + textin + "[/center]")
	anim.play("display_text")
	await(anim.animation_finished)

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


func _on_opcion_1_pressed() -> void: #emite señal para el botón 1 seleccionado
	emit_signal("opcion1")
	


func _on_opcion_2_pressed() -> void: #emite señal para el botón 2 seleccionado
	emit_signal("opcion2")
