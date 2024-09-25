extends Node
var areas_de_recurso = []
var cantidad_hierro = 0
var cantidad_comida = 0
var cantidad_madera = 0
#Hierro 1 comida 2 madera 3
@onready var suelo = $Suelo
@onready var canvas = $"Suelo/CanvasLayer"
func _ready():
	var recurso1 = Zona_de_recursos.new()
	suelo.add_child(recurso1)
	recurso1.iniciar_zona(1,120,40, Vector2(160,0),32000)
	areas_de_recurso.append(recurso1)
	var recurso2 = Zona_de_recursos.new()
	suelo.add_child(recurso2)
	recurso2.iniciar_zona(2,120,40, Vector2(-160,0),32000)
	areas_de_recurso.append(recurso2)
	var recurso3 = Zona_de_recursos.new()
	suelo.add_child(recurso3)
	recurso3.iniciar_zona(3,120,40, Vector2(0,-200),32000)
	areas_de_recurso.append(recurso3)
	#For declarando el nombre a los nodos creados
	var contador_for = 1
	for i in areas_de_recurso:
		i.name = "Area"+ str(contador_for)
		contador_for += 1
#Interfaz
func actualizar_recursos(recurso,cantidad):
	if recurso == 1:
		cantidad_hierro += cantidad
		canvas.actualizar_recursos (1, cantidad_hierro)
	elif recurso == 2:
		cantidad_comida += cantidad
		canvas.actualizar_recursos (2, cantidad_comida)
	else:
		cantidad_madera += cantidad
		canvas.actualizar_recursos (3, cantidad_madera)

#Elimina al Area2D junto a todos sus hijos
func actualizar_area_agotada(objeto):
	areas_de_recurso.erase(objeto)
	objeto.queue_free()

#Devuelve las coordenadas de las areas de recursos
func obtener_coordenadas_area_recursos():
	var lista_coordenadas = []
	for i in areas_de_recurso:
		lista_coordenadas.append(i.collision_shape_2d.position)
	return lista_coordenadas
func obtener_areas_de_recursos():
	return areas_de_recurso

func activar_entered_body_area2d(objeto):
	objeto.body_entered.connect(objeto.entrando_al_recurso)
	objeto.body_exited.connect(objeto.saliendo_del_recurso)
