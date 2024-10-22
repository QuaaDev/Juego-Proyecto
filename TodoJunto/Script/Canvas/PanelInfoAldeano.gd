extends Panel
@onready var nombre = $Nombre
@onready var recurso = $Recurso
@onready var casa = $Casa

func mostrar_info(A,B : int,C):
	#A nombre B recurso C casa perteneciente
	#Edita la informacion con los argumentos enviados
	nombre.text = "Nombre: " + A
	recurso.text = "Recurso: " + descifrar_recurso(B)
	#casa.text = "Pertenece a la casa: " + C
	texto_casa(C)
	
func texto_casa(C):
	#Comprueba si tiene una casa asignada antes de acceder a la info
	if C != null:
		casa.text = "Pertenece a la casa: " + C.name
	else:
		casa.text = "Error, casa no asignada"
func descifrar_recurso(Numero):
	if Numero == 1:
		return "Hierro"
	elif Numero == 2:
		return "Comida"
	elif Numero == 3:
		return "Madera"
	else:
		print("Error tipo de recurso Canvas PanelInfoAldeano, recurso no encontrado.")
		print("El identificador de recurso es: " + str(Numero))
		
func _ready():
	#Desactiva la visibilidad
	visible = false
