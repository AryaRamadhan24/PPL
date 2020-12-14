extends Node2D

var pop_up_quit = false

func _ready():
	pop_up_quit = false
	toggle_popup_quit(false)
	

func _on_play_pressed():
	get_tree().change_scene("res://scene/Play Menu.tscn")
	pass # Replace with function body.

func _on_help_pressed():
	get_tree().change_scene("res://scene/Help Menu.tscn")
	pass # Replace with function body.

func _on_about_pressed():
	get_tree().change_scene("res://scene/About Menu.tscn")
	pass # Replace with function body.

func toggle_popup_quit(state):
	if state:
		$"pop up exit".show()
	else:
		$"pop up exit".hide()
	pop_up_quit==state

func _on_exit_button():
	toggle_popup_quit(!pop_up_quit)
func _exit_yes():
	get_tree().quit()
func _exit_no():
	toggle_popup_quit(false)



