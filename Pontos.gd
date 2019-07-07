extends Node2D

onready var score = get_parent().get_child(0)
onready var pontos = preload("res://Point.tscn")
onready var display = get_parent().get_child(0)
onready var pointlist = []

func _ready():
	for i in range (10):
		putPoint()
	
func _on_Button4_button_down():
	closestpairpoints()
	
func putPoint():
	var point = pontos.instance()
	randomize()
	point.position.x = randi() % 1000 + 22
	randomize()
	point.position.y = randi() % 500 + 22
	randomize()
	pointlist.push_back(point)
	add_child(point)
	
#---------------------------------------------------------------------

func closestpairpoints():
	var x = 10500
	var minor
	var listX = []
	var HX
	var HY
	var Select1
	var Select2
	var Distance

	for j in range(pointlist.size()):
		for i in range(pointlist.size()):
			if pointlist[i].position.x < x:
				minor = i
				x = pointlist[i].position.x
		listX.push_back(pointlist[minor])
		pointlist.remove(minor)
		x = 10500
		
	for i in range (listX.size()):
		print(listX[i].position.x)
	
	for i in range(listX.size()):
		if i == 0:
			HX = listX.back().position.x - listX.front().position.x
			if listX.back().position.y > listX.front().position.y:
				HY = listX.back().position.y - listX.front().position.y
			else:
				HY = listX.front().position.y - listX.back().position.y
			Select1 = listX.front()
			Select2 = listX.back()
			Distance = listX.back().position.distance_to(listX.front().position)
		else:
			var NEWHY
			if listX[i].position.y > listX[i-1].position.y:
				NEWHY = listX[i].position.y - listX[i-1].position.y
			else: 
				NEWHY = listX[i-1].position.y - listX[i].position.y
				
			if HX > (listX[i].position.x - listX[i-1].position.x) or HY > NEWHY:
				if Distance > listX[i].position.distance_to(listX[i-1].position):
					HX = listX[i].position.x - listX[i-1].position.x
					HY = NEWHY
					Select1 = listX[i-1]
					Select2 = listX[i]
					Distance = listX[i].position.distance_to(listX[i-1].position)
	
	Select1.frame = 1
	Select2.frame = 1
	get_parent().get_child(2).hide()