extends Node2D
var existe_sprite = false
@onready var escena_sprite_edificio = preload("res://Scene/SceneSecundarios/EdificioSeleccionado.tscn")
@onready var tile_map = $TileMap

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#Si se pickeo el sprite, este seguira las coordenadas del mouse
	if existe_sprite:
		get_node("Sprite").position = Vector2(get_global_mouse_position().x +20, get_global_mouse_position().y -20)

func boton_apretado():
	#Si no existe el sprite al apretarlo, lo crea
	if !existe_sprite:
		var invocar_escena = escena_sprite_edificio.instantiate()
		invocar_escena.name = "Sprite"
		add_child(invocar_escena)
		existe_sprite = true
		
func _input(event):
	#Boton derecho + tener seleccionado sprite para cancelar
	if event.is_action_pressed("ClickDer") and existe_sprite:
		existe_sprite = false
		get_node("Sprite").queue_free()
	#Boton Izq + tener seleccionado sprite para colocar
	if event.is_action_pressed("ClickIzq") and existe_sprite:
		existe_sprite = false
		get_node("Sprite").queue_free()
		colocar_edificio()
		
func colocar_edificio():
	#tile_map.set_cell(int layer:o,coordenadas de la cell: Vector2, source_id int, atlas_coordenadas Vector2(0,0),alternative_tile int)
	tile_map.set_cell(0,tile_map.local_to_map(Vector2(get_global_mouse_position().x, get_global_mouse_position().y-40)),1,Vector2(0,0),0)
	tile_map.set_cell(0,tile_map.local_to_map(Vector2(get_global_mouse_position().x, get_global_mouse_position().y)),1,Vector2(0,1),0)
	tile_map.set_cell(0,tile_map.local_to_map(Vector2(get_global_mouse_position().x + 40, get_global_mouse_position().y)),1,Vector2(1,1),0)
	tile_map.set_cell(0,tile_map.local_to_map(Vector2(get_global_mouse_position().x + 40, get_global_mouse_position().y-40)),1,Vector2(1,0),0)