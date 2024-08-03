extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var vida = 100

enum Modo {
	FLECHERO,
	MAGO,
	TANQUE,
	
}


#@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var sprite: Sprite2D = $Sprite2D
@onready var collision = $CollisionShape2D

var current_mode := Modo.FLECHERO

var modos := {
	Modo.TANQUE: {
		"idle": "tanque_idle",
		"walk": "tanque_walk",
		"habilidad": "tanque_habilidad",
		"sprite": preload("res://assets/jugador/tanque.jpg")
	},
	Modo.MAGO: {
		"idle": "mago_idle",
		"walk": "mago_walk",
		"habilidad": "mago_habilidad",
		"sprite": preload("res://assets/jugador/mago.jpg")
	},
	Modo.FLECHERO: {
		"idle": "flechero_idle",
		"walk": "flechero_walk",
		"habilidad": "flechero_habilidad",
		"sprite": preload("res://assets/jugador/flechero.jpg")
	}
}

func _ready():
	actualizar_modo()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func cambiar_modo(op):
	current_mode = op
	match op:
		0:
			collision.scale.y = 1.5
		1:
			collision.scale.y = 1
		2:
			collision.scale.y = 1

	actualizar_modo()

func actualizar_modo():
	var modo_actual = modos[current_mode]
	#animated_sprite.animation = modo_actual["idle"]
	sprite.texture = modo_actual["sprite"]

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_1:
			cambiar_modo(0)
		elif event.keycode == KEY_2:
			cambiar_modo(1)
		elif event.keycode == KEY_3:
			cambiar_modo(2)
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

