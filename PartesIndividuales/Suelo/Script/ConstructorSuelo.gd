extends Node

func _ready():
	var recurso1 = Zona_de_recursos.new()
	add_child(recurso1)
	recurso1.iniciar_zona(1,200,40, Vector2(120,0))
	var recurso2 = Zona_de_recursos.new()
	add_child(recurso2)
	#recurso2.iniciar_zona(2,120,40, Vector2(-120,0))
	var recurso3 = Zona_de_recursos.new()
	add_child(recurso3)
	#recurso3.iniciar_zona(3,120,40, Vector2(0,-200))
