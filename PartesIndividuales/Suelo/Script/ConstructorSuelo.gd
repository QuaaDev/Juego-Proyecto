extends Node

func _ready():
	var recurso1 = Zona_de_recursos.new()
	add_child(recurso1)
	recurso1.iniciar_zona(0,200,40, Vector2(0,0))
