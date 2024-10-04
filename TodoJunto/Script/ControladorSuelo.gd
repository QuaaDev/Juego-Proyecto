extends Node2D
var existe_sprite = false
@onready var escena_sprite_edificio = preload("res://Scene/SceneSecundarios/EdificioSeleccionado.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if existe_sprite:
		get_node("Sprite").position = get_global_mouse_position()

func boton_apretado():
	if !existe_sprite:
		var invocar_escena = escena_sprite_edificio.instantiate()
		invocar_escena.name = "Sprite"
		add_child(invocar_escena)
		existe_sprite = true
