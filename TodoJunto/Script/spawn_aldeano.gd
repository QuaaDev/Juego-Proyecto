extends StaticBody2D
@onready var escena_principal = get_parent().get_parent()
@onready var cd_spawn = $CdSpawn
@onready var yo_mismo = $"."
@onready var aldeano = preload("res://Scene/aldeano.tscn")

var limite_aldeanos = 4
var aldeanos_actuales = 0
var en_cd = false
func _process(_delta):
	pass
func _ready():
	cd_spawn.timeout.connect(yo_mismo.terminar_cd)
	yo_mismo.mouse_entered.connect(yo_mismo.el_mouse_entro)
	
	yo_mismo.mouse_exited.connect(yo_mismo.el_mouse_salio)
#Al recibir la señal del ciclo, si hay mas de 300 de comida crea un nuevo aldeano
func consultar_recurso():
	#Limita la cantidad de aldeanos que puede producir 1 casa
	if aldeanos_actuales <= limite_aldeanos:
		if escena_principal.cantidad_comida >= 300 and !en_cd:
			var new_aldeano = aldeano.instantiate()
			new_aldeano.tipo_de_recurso = 2
			new_aldeano.velocidad_recoleccion = 100
			new_aldeano.position = yo_mismo.position
			new_aldeano.name = "Aldeano" + str(randi())
			escena_principal.add_child(new_aldeano)
			escena_principal.actualizar_recursos(2,-300)
			en_cd = true
			cd_spawn.start()
			aldeanos_actuales += 1

func terminar_cd():
	en_cd = false

func el_mouse_entro():
	escena_principal.mouse_entro_a_la_casa(yo_mismo)
func el_mouse_salio():
	escena_principal.mouse_salio_de_la_casa()
