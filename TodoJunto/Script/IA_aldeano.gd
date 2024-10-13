extends CharacterBody2D
@onready var escena_principal = get_parent()
@onready var timer = $Timer
@onready var yo_mismo = $"."

#Recursos para calcular el recurso mas cercano
var coordenadas_recursos
var recurso_mas_cercano
#Recursos para calcular el recurso mas cercano
#Controladores de movimiento
var moverse_x = false
var moverse_y = false
#Controladores de movimiento
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
		moverse_x = true
		moverse_y = true
	else:
		pass
		#print("No quedan recursos de X tipo")
	#resultado_distancia.clear()
func _process(_delta):
	#Interruptor para el movimiento
	if moverse_x or moverse_y:
		#Si hay una diferencia en el eje X entre el recurso y el aldeano, activa el movimiento
		#Si la diferencia es menor a 1 pixeles, desactiva el movimiento del eje
		if moverse_x:
			if (1 < abs(position.x - recurso_mas_cercano.x)):
				#Averigua si la diferencia es negativa o positiva para saber a que lado dirigirse
				if 0 > position.x - recurso_mas_cercano.x:
					velocity.x = velocidad
				else:
					velocity.x = -velocidad
			else:
				#Si no hay diferencia, significa que ya llego al lugar indicado y desactiva el movimiento de dicho eje
				velocity.x = 0
				moverse_x = false
		if moverse_y:
			if (1 < abs(position.y - recurso_mas_cercano.y)):
				if 0 > position.y - recurso_mas_cercano.y:
					velocity.y = velocidad
				else:
					velocity.y = -velocidad
			else:
				velocity.y = 0
				moverse_y = false
		#Ejecuta el movimiento
		move_and_slide()
	pass
#Cuando entra a la zona de recursos, frena el movimiento automaticamente
#Esta señal la envia la zona de recursos al detectar el body
func estoy_dentro_de_la_zona():
	moverse_x = false
	moverse_y = false

#Se resetea el timer para ejecutar el codigo de buscar recursos esperando a que el antiguo desaparezca
func recurso_local_agotado():
	timer.start()

func _ready():
	#Conecta la señal de mouse a las funciones
	yo_mismo.mouse_entered.connect(yo_mismo.el_mouse_entro)
	yo_mismo.mouse_exited.connect(yo_mismo.el_mouse_salio)
#---------------------Señales del mouse-------------------
func el_mouse_entro():
	escena_principal.mouse_entra_al_aldeano(yo_mismo)
func el_mouse_salio():
	escena_principal.mouse_sale_del_aldeano()
#---------------------Señales del mouse-------------------




