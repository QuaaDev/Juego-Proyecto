extends Node2D
@onready var escena_principal = get_parent().get_parent()
@onready var cd_spawn = $CdSpawn
@onready var cd_consulta_recurso= $ConsultarRecurso
@onready var yo_mismo = $"."
@onready var aldeano = preload("res://Scene/aldeano.tscn")
var en_cd = false
func _process(_delta):
	pass
func _ready():
	cd_consulta_recurso.timeout.connect(yo_mismo.consultar_recurso)
	cd_spawn.timeout.connect(yo_mismo.terminar_cd)
func consultar_recurso():
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

func terminar_cd():
	en_cd = false
