extends Node2D

onready var hunter = get_child(0)
onready var relic = get_child(1)
onready var flee = get_child(2)

# Called when the node enters the scene tree for the first time.
func _ready():
	hunter.alvo = relic
	flee.VELOCIDADE_MAX = 85
	flee.alvo = hunter
	set_process(true)

func _process(delta):
	pass