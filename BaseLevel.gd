extends Node2D

onready var closestpairofpoints = preload("res://ClosestPairOfPoints.tscn")
onready var quickhull = preload("res://QuickHull.tscn")
onready var grauA = preload("res://GrauA.tscn")
onready var steeringBehaviors = preload("res://SteeringBehaviors.tscn")
onready var button01 = get_child(0)
onready var button02 = get_child(1)
onready var button03 = get_child(2)
onready var button04 = get_child(3)

func hideall():
	button01.hide()
	button02.hide()
	button03.hide()
	button04.hide()

func showall():
	button01.show()
	button02.show()
	button03.show()
	button04.show()

func _on_Button_button_down():
	var clstprpnt = closestpairofpoints.instance()
	add_child(clstprpnt)
	hideall()


func _on_Button2_button_down():
	var qckhull = quickhull.instance()
	add_child(qckhull)
	hideall()


func _on_Button5_button_down():
	var ga = grauA.instance()
	add_child(ga)
	hideall()

func _on_Button6_button_down():
	var sb = steeringBehaviors.instance()
	add_child(sb)
	hideall()
