extends CanvasLayer
@onready var madera = $Madera
@onready var hierro = $Hierro
@onready var comida = $Comida
@onready var button = $Button
@onready var yo_mismo = $"."
@onready var suelo = $"../Suelo"
#-------------Informacion Aldeano Panel---------------
#De este aldeano se mostrara informacion
var aldeano_en_el_foco
var foco_en_el_aldeano = false
@onready var panel_info_aldeano = $PanelInfoAldeano
#-------------Informacion Aldeano Panel---------------
#-------------Informacion casa panel---------------
var casa_en_el_foco
var foco_en_la_casa = false
@onready var panel_info_casa = $PanelInfoCasa
#-------------Informacion casa panel---------------
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
#------------Input_event-----------------
func _input(event):
	#Si se hace click izq y el mouse esta sobre un aldeano
	if event.is_action_pressed("ClickIzq") and foco_en_el_aldeano:
		#Muestra la informacion del aldeano
		panel_info_aldeano.mostrar_info(aldeano_en_el_foco.name,aldeano_en_el_foco.tipo_de_recurso , "Null")
		panel_info_aldeano.visible = true
	#Si el panel es visible y se apreta el click derecho
	if event.is_action_pressed("ClickDer") and panel_info_aldeano.visible:
		panel_info_aldeano.visible = false
	#Si se hace click izquierdo con el foco sobre la casa
	if event.is_action_pressed("ClickIzq") and foco_en_la_casa:
		panel_info_casa.mostrar_info(casa_en_el_foco.name,"null",0)
		#A nombre B lista_de_aldeanos C recurso en el que se enfocan
		panel_info_casa.visible = true
	if event.is_action_pressed("ClickDer") and panel_info_casa.visible:
		panel_info_casa.visible = false
		
#------------Input_event-----------------
func obtener_aldeano_UI(objeto):
	#Activa el foco sobre el aldeano
	foco_en_el_aldeano = true
	#Obtiene la referencia del aldeano
	aldeano_en_el_foco = objeto
func desactivar_focus_aldeano():
	#Desactiva el foco sobre el aldeano
	foco_en_el_aldeano = false
	
	
func mouse_entro_a_la_casa(objeto):
	#Activa el foco sobre el aldeano
	foco_en_la_casa = true
	#Obtiene la referencia del aldeano
	casa_en_el_foco = objeto
	
func mouse_salio_de_la_casa():
	#Desactiva el foco sobre el aldeano
	foco_en_la_casa = false
