extends Node2D

func _ready():
	pass # Replace with function body.

func _process(delta):
	$percent.text = str(100-(stepify($Timer.get_time_left(),0.1)*20))+"%"
	
func _on_loading_done():
	var lvl = $".".name
	var target = "res://scene/Level/Level "+str(lvl)+".tscn"
	get_tree().change_scene(target)
	
