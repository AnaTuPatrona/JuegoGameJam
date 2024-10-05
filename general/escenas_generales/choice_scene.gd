extends Control

#FAVOR NO TOCAR
@onready var label = $CanvasLayer/BoxContainer/VBoxContainer/HBoxContainer2/RichTextLabel
@onready var button1 = $CanvasLayer/BoxContainer/VBoxContainer/HBoxContainer/opcion1
@onready var button2 = $CanvasLayer/BoxContainer/VBoxContainer/HBoxContainer/opcion2
@onready var container = $CanvasLayer/BoxContainer/VBoxContainer/HBoxContainer
@onready var anim = $CanvasLayer/AnimationPlayer
@onready var box = $CanvasLayer/BoxContainer

var _choiceDictionary={}

signal opcion1
signal opcion2

func show_animation() -> void: #animacion de entrada
	anim.play("show")
	await(anim.animation_finished)
	 
func hide_animation() -> void: #animacion de salida
	box.visible = false
	anim.play_backwards("show")
	await(anim.animation_finished)

func display_text(textin: String) -> void: #funcion para mostrar texto, solo recibe el texto como parametro
	container.visible = false
	box.visible = true
	label.text = ("[center]" + textin + "[/center]")
	anim.play("display_text" )
	await(anim.animation_finished)

func set_question(texto: String, option1: String, option2: String):
	await(show_animation())
	await(display_option(texto, option1, option2))

func set_questionV2(texto: String, options: Dictionary):
	await(show_animation())
	await(display_optionV2(texto, options))
	
func display_option(textin: String, option1: String, option2: String) -> void: #funcion para mostrar panel de desiciones, texto y ambas opciones como parametro
	button1.text = option1
	button2.text = option2
	container.visible = true
	box.visible = true
	label.text = ("[center]" + textin + "[/center]")
	anim.play("display_text")
	await(anim.animation_finished)
	
func display_optionV2(textin: String, options: Dictionary) -> void: #funcion para mostrar panel de desiciones, texto y ambas opciones como parametro
	button1.text = options.get(true)
	button2.text = options.get(false)
	_choiceDictionary=options
	container.visible = true
	box.visible=true
	label.text = ("[center]" + textin + "[/center]")
	anim.play("display_text")
	await(anim.animation_finished)


func _ready() -> void:
	$CanvasLayer.layer=3


func _process(delta: float) -> void:
	pass


func _on_opcion_1_pressed() -> void: #emite señal para el botón 1 seleccionado
	emit_signal("opcion1")
	


func _on_opcion_2_pressed() -> void: #emite señal para el botón 2 seleccionado
	emit_signal("opcion2")
