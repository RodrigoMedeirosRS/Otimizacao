extends Node2D

onready var main = get_parent()

func _on_Button3_button_down():
	main.showall()
	queue_free()
