extends CharacterBody2D
const SPEED = 300.0
@onready var tile_map = $"../TileMap"
#Hay que recibir la señal en el objeto 

#Se declara las variables de las areas2d
@onready var area1
@onready var area2
@onready var area3
#Area2D

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
	#Se hace time out para dar tiempo a crear todos los nodos antes de proceder
	area1 = $"../Area1"
	area2 = $"../Area2"
	area3 = $"../Area3"
	#Se hace referencia de las areas y almacenarlas
	#Se le conecta a la señal con Variable.Señal.connect(Funcion que recibe la señal)
	area1.body_entered.connect(nose)
	area2.body_entered.connect(nose)
	area3.body_entered.connect(nose)
func nose(body): #Esta funcion recibe la señal
	print("nose")
#Area2D
