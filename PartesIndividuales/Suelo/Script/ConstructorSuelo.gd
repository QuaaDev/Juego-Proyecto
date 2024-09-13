extends Node
var contador_areas_recursos
func _ready():
	var recurso1 = Zona_de_recursos.new()
	add_child(recurso1)
	recurso1.iniciar_zona(1,120,40, Vector2(160,0),32000)
	var recurso2 = Zona_de_recursos.new()
	add_child(recurso2)
	recurso2.iniciar_zona(2,120,40, Vector2(-160,0),32000)
	var recurso3 = Zona_de_recursos.new()
	add_child(recurso3)
	recurso3.iniciar_zona(3,120,40, Vector2(0,-200),32000)
	#Cambia el nombre de las areas para usar la señal luego
	recurso1.name = "Area1"
	recurso2.name = "Area2"
	recurso3.name = "Area3"
