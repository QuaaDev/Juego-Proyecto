extends Panel
@onready var nombre = $Nombre
@onready var aldeanos = $Aldeanos
@onready var focus_recurso = $FocusRecurso


func mostrar_info(A,B,C : int):
	#A nombre B lista_de_aldeanos C recurso en el que se enfocan
	#Edita la informacion con los argumentos enviados
	nombre.text = "Nombre: " + A
	aldeanos.text = "Aldeanos: " + transformar_array_a_string(B)
	#Aqui ira la lista de aldeanos que almacena la casa
	focus_recurso.text = "Se centran en el recurso: " + descifrar_recurso(C)

func descifrar_recurso(Numero):
	if Numero == 1:
		return "Hierro"
	elif Numero == 2:
		return "Comida"
	elif Numero == 3:
		return "Madera"
	else:
		print("Error tipo de recurso Canvas PanelInfoCasa, recurso no encontrado.")
		print("El identificador de recurso es: " + str(Numero))
		return "Error"
		
func _ready():
	#Desactiva la visibilidad
	visible = false
	
func transformar_array_a_string(A):
	#Retorna un texto unido del nombre de los aldeanos
	var texto = ""
	if A.size() > 0:
		for i in A:
			texto = texto + i.name
	else:
		return "Error, lista vacia transformar_array_a_string(A)/PanelInfoCasa"
	return texto
