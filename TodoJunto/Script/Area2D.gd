extends Area2D
class_name Zona_de_recursos
#Recursos

var tipo_recurso : int #Recurso de la zona
#Hierro 1 comida 2 madera 3
var velocidad_actualizacion_recursos = 10000
#Recursos
var radio_de_la_zona : int #Radio del Circle Shape
var tamaño_cells : int #Cada cuantos pixeles se colocara una cell
var coordenadas_shape : Vector2 #Coordenadas de la zona en el mapa
var cantidad_del_recurso : int
var collision_shape_2d #Collisionshape que le dara hitbox
var lista_de_cuadriculas_a_actualizar = []
@onready var tile_map = $"../TileMap"
@onready var yo_mismo = $"."
@onready var EscenaPrincipal = get_parent().get_parent() #<--- actualizar
#Los nodos deben de estar a la misma altura para funcionar la ruta
#Seccion TileMap
func editar_cuadricula():
	var radio = collision_shape_2d.shape.radius  #Obtiene el radio
	var tamaño_cuadricula = tamaño_cells #Declara el tamaño de las cuadriculas
	var centro_x
	var centro_y
	#lista_de_cuadriculas_a_actualizar.append(Vector2(coordenadas_shape.x, coordenadas_shape.y))
	for x in range(-radio, radio, tamaño_cuadricula):
		for y in range(-radio, radio, tamaño_cuadricula):
			@warning_ignore("integer_division")
			centro_x = x + tamaño_cuadricula / 2
			@warning_ignore("integer_division")
			centro_y = y + tamaño_cuadricula / 2
			if centro_x**2 + centro_y**2 <= radio**2: 
				#X**2 + y**2 = z**2. Z es el diametro del circulo
				#Si pertenece a la ecuacion, se agrega a la lista de cuadriculas a actualizar
				lista_de_cuadriculas_a_actualizar.append(Vector2(x + coordenadas_shape.x, y + coordenadas_shape.y))  
				# Guarda la cuadricula sumandole al eje X e Y la posicion central del circulo
	#print(lista_de_cuadriculas_a_actualizar)
	for i in lista_de_cuadriculas_a_actualizar: #Se actualiza las cuadriculas
		tile_map.set_cell(0,tile_map.local_to_map(i),0,Vector2(tipo_recurso,0),0)
		#tile_map.set_cell(int layer:o,coordenadas de la cell: Vector2, source_id int, atlas_coordenadas Vector2(0,0),alternative_tile int)
		#Con esos datos se cambia cell de manera individual
		#layer: no se que es, coordenadas es la coordenada individual de la cell, se obtiene con local_to_map, source id no se que es, atlas coordenadas es 
		#la division del sprite en la cuadricula, alternative tile no se que es
	#Radio 40 = 4
	#Radio 80 = 12 | +8
	#Radio 120 = 32 | +20
	#Radio 160 = 52 | +20
	#Radio 200 = 80 | +28
	#Radio 240 = 112 | +32
	pass
func recurso_agotado():
	#Actualiza el tilemap al atlas predeterminado
	for i in lista_de_cuadriculas_a_actualizar:
		tile_map.set_cell(0,tile_map.local_to_map(i),0,Vector2(0,0),0)
	#Elimina el Area2D junto a todos sus hijos
	EscenaPrincipal.actualizar_area_agotada(yo_mismo)
func iniciar_zona(recurso : int,radio : int, tamaño_cell : int, coordenadas_shape2 : Vector2, cantidad : int):
	#Se carga las propiedades del Area2D
	cantidad_del_recurso = cantidad
	tipo_recurso = recurso
	radio_de_la_zona = radio
	tamaño_cells = tamaño_cell
	coordenadas_shape = coordenadas_shape2
	#Se crea el collision shape
	collision_shape_2d = CollisionShape2D.new()
	collision_shape_2d.debug_color = Color(0,0,0,1)
	collision_shape_2d.disabled = false
	collision_shape_2d.one_way_collision = false
	collision_shape_2d.one_way_collision_margin = 1.0
	collision_shape_2d.position = coordenadas_shape
	add_child(collision_shape_2d)
	#Se crea el circleshape
	var shape_circular = CircleShape2D.new()
	shape_circular.radius = radio_de_la_zona
	#Se le agrega el shape al collisionshape
	collision_shape_2d.set_shape(shape_circular)
	editar_cuadricula()
	
#Seccion recursos
@onready var temporizador = Timer.new()
func _ready():
	#Se crea el temporizador y su señal
	yo_mismo.add_child(temporizador)
	temporizador.paused = true
	temporizador.wait_time = 1
	temporizador.start()
	temporizador.timeout.connect(actualizar_recurso)
	
func entrando_al_recurso(_body):
	temporizador.paused = false
	
func saliendo_del_recurso(_body):
	temporizador.paused = true


func actualizar_recurso():
	if cantidad_del_recurso >= 0:
		cantidad_del_recurso -= velocidad_actualizacion_recursos
		EscenaPrincipal.actualizar_recursos(tipo_recurso,velocidad_actualizacion_recursos)
	else:
		recurso_agotado()
