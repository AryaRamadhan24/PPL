extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if(Global.get_username() !=  "Guest"):
		$username.text = str(Global.get_username())
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_back_pressed():
	get_tree().change_scene("res://scene/Main Menu.tscn")
	pass # Replace with function body.


func _on_play_pressed():
	Global.set_username($username.text)
	get_tree().change_scene("res://scene/Level Menu.tscn")
	pass # Replace with function body.
