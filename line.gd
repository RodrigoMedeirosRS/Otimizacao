extends Node2D

var from
var to

func set_lines(_from, _to):
    from = _from
    to = _to

func _draw():
    draw_line(from, to, Color("df7126"), 10)