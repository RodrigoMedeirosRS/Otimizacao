extends Node2D

onready var pontos = preload("res://Point.tscn")
onready var line = preload("res://line.tscn")
onready var display = get_parent().get_child(0)
onready var pointlist = []

func _ready():
	for i in range (20):
		putPoint()
		set_process(true)

func _on_Button4_button_down():
	grauA()

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
func ordenaY():
	var listY = []
	var minor
	var y = 0
	
	for j in range(pointlist.size()):
		for i in range(pointlist.size()):
			if pointlist[i].position.y > y:
				minor = i
				y = pointlist[i].position.y
		listY.push_front(pointlist[minor])
		pointlist.remove(minor)
		y = 0
	return listY

func setAngle(origin):
	origin.frame = 1
	for i in range(pointlist.size() - 1):
		var a = origin.get_angle_to(pointlist[i].position)
		a = a * -180 / 3.14159
		pointlist[i].angle = int(a)

func ordenaAngle():
	var listY = []
	var minor
	var y = -90
	
	for j in range(pointlist.size()):
		for i in range(pointlist.size()):
			if pointlist[i].angle > y:
				minor = i
				y = pointlist[i].angle
		listY.push_front(pointlist[minor])
		pointlist.remove(minor)
		y = 0
	return listY

func crossproduct(p1, p2, p3):
	return (p2.position.x - p1.position.x)*(p3.position.y - p1.position.y) - (p3.position.x - p1.position.x)*(p2.position.y - p1.position.y);

func GrahanScan():
	var pilha = []
	
	pilha.push_back(pointlist[0])
	pilha.push_back(pointlist[1])
	
	for i in range(2, pointlist.size()):
		var point1 = pilha[pilha.size()-2]
		var point2 = pilha.back()
		var point3 = pointlist[i]
		
		var aux = crossproduct(point1, point2, point3)
		if aux == 0:
			pilha.pop_back()
			pilha.push_back(pointlist[i])
		elif aux < 0:
			pilha.push_back(pointlist[i])
		else:
			while aux >= 0 and pilha.size() > 2:
				pilha.pop_back()
				point1 = pilha[pilha.size()-2]
				point2 = pilha.back()
				aux = crossproduct(point1, point2, point3)
			
			pilha.push_back(pointlist[i])

	desenha(pilha)
	
func desenha(pilha):
	for i in range(pilha.size()):
		pilha[i].frame =1
	
	for i in range(pilha.size()-1):
		var lineInstance = line.instance()
		lineInstance.set_lines(pilha[i].position, pilha[i+1].position)
		lineInstance.position = position
		get_parent().add_child(lineInstance)
		
	var lineInstance = line.instance()
	lineInstance.set_lines(pilha.back().position, pilha.front().position)
	lineInstance.position = position
	get_parent().add_child(lineInstance)

func grauA():
	pointlist = ordenaY()
	setAngle(pointlist.back())
	pointlist = ordenaAngle()
	for i in range(pointlist.size()):
		pointlist[i].angle = i
	GrahanScan()