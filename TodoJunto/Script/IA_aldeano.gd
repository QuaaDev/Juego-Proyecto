extends CharacterBody2D
@onready var escena_principal = get_parent()
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
#Cuando todo este iniciado, ejecuta el codigo
func _on_timer_timeout():
	buscar_recurso_cercano()
func buscar_recurso_cercano():
	var distancia = []
	var resultado_distancia = []
	#Obtiene las coordenadas de todos los recursos
	coordenadas_recursos = escena_principal.obtener_coordenadas_area_recursos()
	#Almacena la diferencia entre las coordenadas en valor absoluto
	for i in coordenadas_recursos:
		distancia.append(Vector2(
			abs(int(i.x) - int(position.x)),
			abs(int(i.y) - int(position.y))
			))
	#Convierte la distancia de Vector2 a int
	for i in distancia:
		resultado_distancia.append(i.x + i.y)
	#Obtiene las coordenadas del recurso mas cercano al aldeano
	recurso_mas_cercano = escena_principal.areas_de_recurso[resultado_distancia.find(resultado_distancia.min())].coordenadas_shape
	#Activa el movimiento
	#El aldeano ira AL CENTRO del recurso, hay que arreglar esto mas adelante para que solo sea necesario el borde
	moverse_x = true
	moverse_y = true
func _process(_delta):
	#Interruptor para el movimiento
	if moverse_x or moverse_y:
		#Si hay una diferencia en el eje X entre el recurso y el aldeano, activa el movimiento
		if (0 < abs(position.x - recurso_mas_cercano.x)):
			#Averigua si la diferencia es negativa o positiva para saber a que lado dirigirse
			if 0 > position.x - recurso_mas_cercano.x:
				velocity.x = velocidad
			else:
				velocity.x = -velocidad
		else:
			#Si no hay diferencia, significa que ya llego al lugar indicado y desactiva el movimiento de dicho eje
			moverse_x = false
		if (0 < abs(position.y - recurso_mas_cercano.y)):
			if 0 > position.y - recurso_mas_cercano.y:
				velocity.y = velocidad
			else:
				velocity.y = -velocidad
		else:
			moverse_y = false
		#Ejecuta el movimiento
		move_and_slide()
	pass
