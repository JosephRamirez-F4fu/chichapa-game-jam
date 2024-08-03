extends CharacterBody2D

const GRAVEDAD := 10.0
const ACELERACION := 150.0
const SALTAR := 300.0

var direccion := 0.0

enum Modo {
	TANQUE,
	MAGO,
	FLECHERO
}


#@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
#@onready var sprite: Sprite2D = $Sprite2D

var current_mode := Modo.TANQUE

var modos := {
	Modo.TANQUE: {
		"idle": "tanque_idle",
		"walk": "tanque_walk",
		"habilidad": "tanque_habilidad",
		#"sprite": preload("res://sprites/tanque.png")
	},
	Modo.MAGO: {
		"idle": "mago_idle",
		"walk": "mago_walk",
		"habilidad": "mago_habilidad",
		#"sprite": preload("res://sprites/mago.png")
	},
	Modo.FLECHERO: {
		"idle": "flechero_idle",
		"walk": "flechero_walk",
		"habilidad": "flechero_habilidad",
		#"sprite": preload("res://sprites/flechero.png")
	}
}

func _ready():
	actualizar_modo()

func _physics_process(delta):
	direccion = Input.get_axis("ui_left", "ui_right")
	velocity.x = direccion * ACELERACION
	
	if is_on_floor() and Input.is_action_just_pressed("ui_accept"):
		velocity.y -= SALTAR
		
	if !is_on_floor():
		velocity.y += GRAVEDAD 

	move_and_slide()


func cambiar_modo():
	current_mode = (current_mode + 1) % Modo.size()
	actualizar_modo()

func actualizar_modo():
	var modo_actual = modos[current_mode]
	#animated_sprite.animation = modo_actual["idle"]
	#sprite.texture = modo_actual["sprite"]

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_T:
			cambiar_modo()
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			usar_habilidad()

func usar_habilidad():
	var modo_actual = modos[current_mode]
	#animated_sprite.animation = modo_actual["habilidad"]
	match current_mode:
		Modo.TANQUE:
			habilidad_tanque()
		Modo.MAGO:
			habilidad_mago()
		Modo.FLECHERO:
			habilidad_flechero()

func habilidad_tanque():
	pass

func habilidad_mago():
	pass

func habilidad_flechero():
	pass

