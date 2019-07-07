extends KinematicBody2D

onready var sprite = get_child(0)

var VELOCIDADE_MAX = 300
const FORCA_MAX = 0.02
var velocidade = Vector2()

onready var pegou
onready var alvo

export (int, "SEEK", "FLEE", "STATIC") var comportamento = 0

func _ready():
	set_physics_process(true)
	
func _physics_process(delta):
	changeVisual()
	
	if comportamento != 2 and alvo != null:
		velocidade = steer(alvo)
		pegou = move_and_collide(velocidade * delta)

func changeVisual():
	if comportamento == 0 and sprite.frame != 2:
		sprite.frame = 2
	if comportamento == 1 and sprite.frame != 0:
		sprite.frame = 0
	if comportamento == 2 and sprite.frame != 3:
		sprite.frame = 3

func steer(alvo):
	var a = alvo.position - position
	var velocidadeDesejada = a.normalized() \
	* VELOCIDADE_MAX
	if comportamento == 0:
		pass
	elif comportamento == 1:
		velocidadeDesejada = -velocidadeDesejada
	var steer = velocidadeDesejada - velocidade
	var velocidadeDoAlvo = velocidade + (steer * FORCA_MAX)
	return(velocidadeDoAlvo)
