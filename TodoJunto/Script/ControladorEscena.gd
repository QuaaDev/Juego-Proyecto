extends Node
var areas_de_recurso = []
var cantidad_hierro = 0
var cantidad_comida = 0
var cantidad_madera = 0
#Hierro 1 comida 2 madera 3
@onready var suelo = $Suelo
@onready var canvas = $"CanvasLayer"
@onready var ciclo = $Ciclo
@onready var yo_mismo = $"."

func _ready():
	ciclo.timeout.connect(yo_mismo.nuevo_ciclo)
	var recurso1 = Zona_de_recursos.new()
	suelo.add_child(recurso1)
	recurso1.iniciar_zona(1,80,40, Vector2(160,0),3200)
	areas_de_recurso.append(recurso1)
	var recurso2 = Zona_de_recursos.new()
	suelo.add_child(recurso2)
	recurso2.iniciar_zona(2,80,40, Vector2(-160,0),3200)
	areas_de_recurso.append(recurso2)
	var recurso3 = Zona_de_recursos.new()
	suelo.add_child(recurso3)
	recurso3.iniciar_zona(3,80,40, Vector2(0,-200),3200)
	areas_de_recurso.append(recurso3)
	var recurso4 = Zona_de_recursos.new()
	suelo.add_child(recurso4)
	recurso4.iniciar_zona(1,80,40, Vector2(-320,0),32000)
	areas_de_recurso.append(recurso4)
	var recurso5 = Zona_de_recursos.new()
	suelo.add_child(recurso5)
	recurso5.iniciar_zona(2,80,40, Vector2(320,0),32000)
	areas_de_recurso.append(recurso5)
	var recurso6 = Zona_de_recursos.new()
	suelo.add_child(recurso6)
	recurso6.iniciar_zona(3,80,40, Vector2(0,200),32000)
	areas_de_recurso.append(recurso6)
	#For declarando el nombre a los nodos creados
	var contador_for = 1
	for i in areas_de_recurso:
		i.name = "Area"+ str(contador_for)
		contador_for += 1
	actualizar_recursos(1,500)
	actualizar_recursos(2,500)
	actualizar_recursos(3,500)
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

#Los ciclos defienen el tiempo del juego
func nuevo_ciclo():
	print("---------------------------------------------")
	print("Un ciclo empieza")
	var hijos_aldeanos = []
	#Recolecta todos los hijos con el nombre aldeano
	for i in yo_mismo.get_children():
		if i.name.contains("Aldeano"):
			hijos_aldeanos.append(i)
	#Si la cantidad de comida es menor a lo que comen todos los aldeanos, algunos moriran de hambre
	if cantidad_comida < hijos_aldeanos.size()*60:
		#Calcula las muertes por hambre
		var cantidad_muertes_por_hambre = int((hijos_aldeanos.size()*60 - cantidad_comida)/60)
		#Ejecuta las muertes seleccionando un aldeano random, lo elimina de la lista de aldeanos y luego queue free
		for i in range(0,cantidad_muertes_por_hambre):
			var indice_seleccionado = randi() % hijos_aldeanos.size()
			var aldeano_seleccionado = hijos_aldeanos[indice_seleccionado]
			hijos_aldeanos.remove_at(indice_seleccionado)
			aldeano_seleccionado.queue_free()
		#Pone la comida en 0 para evitar numeros negativos
		actualizar_recursos(2,-cantidad_comida)
		print(cantidad_muertes_por_hambre)
	else:
		#Si hay suficiente comida, resta la comida consumida por aldeanos
		actualizar_recursos(2,-hijos_aldeanos.size()*60)
	#Luego de haber alimentado a las unidades, se propone el crear nuevas unidades
	#El spawn averigua si hay comida suficiente para crear nuevas unidades
	suelo.señal_ciclo()
