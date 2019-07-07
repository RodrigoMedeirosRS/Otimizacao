extends Sprite

onready var angle = 000
onready var label = get_child(0)

func _ready():
	set_process(true)

func _process(delta):
	label.text = String(angle)
