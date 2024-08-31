extends TileMap


# Called when the node enters the scene tree for the first time.
func _ready():
	erase_cell(0, Vector2(0,0)) #Elimina el tileset con los parametros layer: int, coords: Vector2i
	#print(local_to_map(Vector2(-100, 420)))
	erase_cell(0,local_to_map(Vector2(-100, 420)))#Global a tilemap
	#print(map_to_local(Vector2(-3,10)))
	erase_cell(0,map_to_local(Vector2(-3,10)))#Tilemap a global

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
