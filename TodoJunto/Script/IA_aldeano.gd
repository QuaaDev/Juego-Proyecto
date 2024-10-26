extends CharacterBody2D
@onready var escena_principal = get_parent()
@onready var timer = $Timer
@onready var yo_mismo = $"."
#-------------Navegation Path----------------
@onready var navegacion = $NavigationAgent2D
var desactivar_navegacion = true
@onready var timer_navegacion = $TimerNavegacion
#-------------Navegation Path----------------
#Aca se registra en que casa vive el aldeano
var casa_asignada
#Recursos para calcular el recurso mas cercano
var coordenadas_recursos
var recurso_mas_cercano
#Recursos para calcular el recurso mas cercano
#Velocidad del aldeano
const velocidad = 40
#Velocidad del aldeano
var movimientos_repetidos_x = []
var movimientos_repetidos_y = []
@export var tipo_de_recurso : int
@export var velocidad_recoleccion : int
#Cuando todo este iniciado, ejecuta el codigo
func _on_timer_timeout():
	buscar_recurso_cercano()
func buscar_recurso_cercano():
	var distancia = []
	var resultado_distancia = []
	#Almacena las coordenadas que coincide con el recurso
	var lista_de_coordenadas_validas = []
	var areas_de_recursos = escena_principal.obtener_areas_de_recursos()
	for i in areas_de_recursos:
		if i.tipo_recurso == tipo_de_recurso:
			lista_de_coordenadas_validas.append(i.collision_shape_2d.position)
	#Obtiene las coordenadas de todos los recursos
	#Guarda en lista_de_coordenadas_validas los recursos q coincide con el aldeano
	#Almacena la diferencia entre las coordenadas en valor absoluto
	for i in lista_de_coordenadas_validas:
		distancia.append(Vector2(
			abs(int(i.x) - int(position.x)),
			abs(int(i.y) - int(position.y))
			))
	#Convierte la distancia de Vector2 a int
	for i in distancia:
		resultado_distancia.append(i.x + i.y)
	#Obtiene las coordenadas del recurso mas cercano al aldeano
	#Si la lista no logro almacenar informacion significa que no hay recursos
	#Si no hay recursos, se saltea el codigo para evitar errores
	if resultado_distancia.size() > 0:
		#Busca en la lista de coordenadas REALES el indice que coincide con el indice del recurso mas cercano del mismo tipo
		recurso_mas_cercano = lista_de_coordenadas_validas[resultado_distancia.find(resultado_distancia.min())]
		#Activa el movimiento
		#El aldeano ira AL CENTRO del recurso, hay que arreglar esto mas adelante para que solo sea necesario el borde
		#Pone de target las coordenadas del recurso
		#Se le envia las coordenadas mas cercanas a la funcion para obtener un punto aleatorio
		navegacion.target_position = obtener_posicion_aleatoria_del_recurso(recurso_mas_cercano, 80) #<-- hay que mejorar el parametro de radio mas adelante, actualmente es fijo en 80
		#Activa el movimiento
		desactivar_navegacion = false
	else:
		#Desactiva el movimiento
		desactivar_navegacion = true
		#print("No quedan recursos de X tipo")
	#resultado_distancia.clear()
func _process(_delta):
	#(Si la navegacion esta activada) y (Si la distancia entre el final del camino es menor a 10 pixeles) ejecuta el movimiento
	if !desactivar_navegacion:#<--- esto se podria optimizar haciendo que se ejecute cada X segundos, en vez de cada frame
		#Obtiene la direccion del proximo nodo que debe alcanzar
		var dir = to_local(navegacion.get_next_path_position()).normalized()
		#Aplica velocidad segun la direccion
		velocity = dir * velocidad
		move_and_slide()
	pass
#Cuando entra a la zona de recursos, frena el movimiento automaticamente
#Esta señal la envia la zona de recursos al detectar el body
func estoy_dentro_de_la_zona(): #Esta funcion quedo obsoleta, actualmente no tiene utilidad.
	#desactivar_navegacion = true
	pass

#Se resetea el timer para ejecutar el codigo de buscar recursos esperando a que el antiguo desaparezca
func recurso_local_agotado():
	timer.start()
func obtener_posicion_aleatoria_del_recurso(coordenadas, radio):
	#Devuelve una coordenada entre dos limites en el eje X y dos del eje Y, por lo tanto entregara una coordenada aleatoria del area entregada
	return Vector2(randi_range(coordenadas.x+radio, coordenadas.x-radio),randi_range(coordenadas.y+radio, coordenadas.y-radio))
	#El radio es 80
func _ready():
	#Conecta la señal de mouse a las funciones
	yo_mismo.mouse_entered.connect(self.el_mouse_entro)
	yo_mismo.mouse_exited.connect(self.el_mouse_salio)
	timer_navegacion.timeout.connect(self.comprobar_objetivo_final_recorrido)
#---------------------Señales del mouse-------------------
func el_mouse_entro():
	escena_principal.mouse_entra_al_aldeano(yo_mismo)
func el_mouse_salio():
	escena_principal.mouse_sale_del_aldeano()
#---------------------Señales del mouse-------------------
func comprobar_objetivo_final_recorrido():
	#cada timeout comprueba si estan cerca del nodo objetivo, si es asi se actualiza el objetivo
	#Esto hace que caminen sin parar sobre su nodo y evita el error de no actualizarse cuando el recurso se agota
	if navegacion.distance_to_target() < 10:
		desactivar_navegacion = true
		buscar_recurso_cercano()

