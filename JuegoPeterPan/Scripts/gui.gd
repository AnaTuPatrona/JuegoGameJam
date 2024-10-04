extends Node2D

var life: int = 3
func _on_player_reduce_life() -> void:
	if life <= 3:
		$HBoxContainer/Heart3.visible = false
	if life <= 2:
		$HBoxContainer/Heart2.visible = false
	if life <= 1:
		$HBoxContainer/Heart1.visible = false
	life = life -1
