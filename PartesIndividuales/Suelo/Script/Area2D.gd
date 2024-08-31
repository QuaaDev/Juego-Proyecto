extends Area2D
@onready var collision_shape_2d = $CollisionShape2D
@onready var tile_map = $"../TileMap"
#Suponiendo que cada celda son de 40 pixeles
var coordenadas_shape
# Called when the node enters the scene tree for the first time.
func _ready():
	coordenadas_shape = collision_shape_2d.position #Tipo Vector2D
	#Obtiene el centro del radio del circulo
	obtener_cuadricula()
func obtener_cuadricula():
	var radio = collision_shape_2d.shape.radius  #Obtiene el radio
	var tamaño_cuadricula = 40 #Declara el tamaño de las cuadriculas
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
	print(lista_de_cuadriculas_a_actualizar)
	for i in lista_de_cuadriculas_a_actualizar: #Se actualiza las cuadriculas
		tile_map.erase_cell(0, tile_map.local_to_map(i))
	pass
#Probando git
