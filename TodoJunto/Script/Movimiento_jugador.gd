extends CharacterBody2D
const SPEED = 300.0
@onready var tile_map = $"../Suelo/TileMap"

#Se declara las variables de las areas2d
@onready var area1
@onready var area2
@onready var area3
#Area2D
#Referencia al controlador principal
@onready var EscenaPrincipal = get_parent() #<--- actualizar principal escena


func _physics_process(_delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	var direction2 = Input.get_axis("ui_up", "ui_down")
	if direction2:
		velocity.y = direction2 * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	move_and_slide()

#Area2D
func _on_timer_timeout():
	#Se recibe la lista de areas de recurso
	var lista_de_areas_de_recurso = EscenaPrincipal.areas_de_recurso 
	for i in lista_de_areas_de_recurso:
		#Se conecta cada recurso al jugador
		i.body_entered.connect(i.entrando_al_recurso)
		i.body_exited.connect(i.saliendo_del_recurso)
		#Se conectan a la funcion del objeto del area
		#Se hace time out para dar tiempo a crear todos los nodos antes de proceder
		#Se le conecta a la señal con Variable.Señal.connect(Funcion que recibe la señal)
#Area2D
