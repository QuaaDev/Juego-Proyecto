extends CanvasLayer
@onready var madera = $Madera
@onready var hierro = $Hierro
@onready var comida = $Comida
@onready var button = $Button
@onready var yo_mismo = $"."
@onready var suelo = $"../Suelo"

@onready var escena_sprite_edificio = preload("res://Scene/SceneSecundarios/EdificioSeleccionado.tscn")
func _ready():
	madera.text = "MADERA FACHERA: 0"
	hierro.text = "HIERRO FACHERO: 0"
	comida.text = "COMIDA FACHERA: 0" 
	#Se conecta el boton
	button.pressed.connect(suelo.boton_apretado)
func actualizar_recursos (recurso, cantidad):
	if recurso == 1:
		hierro.text = "HIERRO FACHERO: " + str(cantidad)
	elif recurso == 2:
		comida.text = "COMIDA FACHERA: " + str(cantidad)
	else:
		madera.text = "MADERA FACHERA: " + str(cantidad)
