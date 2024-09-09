extends Area2D
class_name Zona_de_recursos
var tipo_recurso : int #Recurso de la zona
var radio_de_la_zona : int #Radio del Circle Shape
var tamaño_cells : int #Cada cuantos pixeles se colocara una cell
var coordenadas_shape : Vector2 #Coordenadas de la zona en el mapa
var collision_shape_2d #Collisionshape que le dara hitbox
@onready var tile_map = $"../TileMap"
#Los nodos deben de estar a la misma altura para funcionar la ruta
func editar_cuadricula():
	var radio = collision_shape_2d.shape.radius  #Obtiene el radio
	var tamaño_cuadricula = tamaño_cells #Declara el tamaño de las cuadriculas
	var lista_de_cuadriculas_a_actualizar = []
	var centro_x
	var centro_y
	#lista_de_cuadriculas_a_actualizar.append(Vector2(coordenadas_shape.x, coordenadas_shape.y))
	for x in range(-radio, radio, tamaño_cuadricula):
		for y in range(-radio, radio, tamaño_cuadricula):
			centro_x = x + tamaño_cuadricula / 2
			centro_y = y + tamaño_cuadricula / 2
			if centro_x**2 + centro_y**2 <= radio**2: 
				#X**2 + y**2 = z**2. Z es el diametro del circulo
				#Si pertenece a la ecuacion, se agrega a la lista de cuadriculas a actualizar
				lista_de_cuadriculas_a_actualizar.append(Vector2(x + coordenadas_shape.x, y + coordenadas_shape.y))  
				# Guarda la cuadricula sumandole al eje X e Y la posicion central del circulo
	#print(lista_de_cuadriculas_a_actualizar)
	for i in lista_de_cuadriculas_a_actualizar: #Se actualiza las cuadriculas
		tile_map.erase_cell(0, tile_map.local_to_map(i))
		tile_map.set_cell(0,tile_map.local_to_map(i),0,Vector2(1,0),0)
		#tile_map.set_cell(int layer:o,coordenadas de la cell: Vector2, source_id int, atlas_coordenadas Vector2(0,0),alternative_tile int)
		#Con esos datos se cambia cell de manera individual
		#layer: no se que es, coordenadas es la coordenada individual de la cell, se obtiene con local_to_map, source id no se que es, atlas coordenadas es 
		#la division del sprite en la cuadricula, alternative tile no se que es
	pass
#Probando git
func iniciar_zona(recurso : int,radio : int, tamaño_cell : int, coordenadas_shape2 : Vector2):
	#Se carga las propiedades del Area2D
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
