extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var vida = 100

enum Modo {
	FLECHERO,
	MAGO,
	TANQUE,
}

@onready var animated_sprite = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var collision = $CollisionShape2D
@onready var cooldown = $cooldown
@onready var cooldown_cambio_personaje = $cooldown_cambio_personaje
@onready var change = $transformacion

var flecha = preload("res://proyectil.tscn")

var current_mode := Modo.FLECHERO

var modos := {
	Modo.TANQUE: {
		"jump": "tanque_jump",
		"walk": "tanque_walk",
		"habilidad": "tanque_habilidad",
		"sprite": preload("res://assets/jugador/tanque/tanque.png")
	},
	Modo.MAGO: {
		"jump": "mago_jump",
		"walk": "mago_walk",
		"habilidad": "mago_habilidad",
		"sprite": preload("res://assets/jugador/curador/curador.png")
	},
	Modo.FLECHERO: {
		"jump": "flechero_jump",
		"walk": "flechero_walk",
		"habilidad": "flechero_habilidad",
		"sprite": preload("res://assets/jugador/flechero/arquero.png")
	}
}

func _ready():
	add_to_group("Jugador")
	cambiar_modo(0)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		play_jump_animation()

	var direction = Input.get_axis("ui_left", "ui_right")

	if Input.is_action_pressed("shoot"):
		usar_habilidad()

	if Input.is_action_just_pressed("ui_left"):
		play_walk_animation()
		sprite.flip_h = true

	elif Input.is_action_just_pressed("ui_right"):
		play_walk_animation()
		sprite.flip_h = false

	if Input.is_action_just_released("ui_left") or Input.is_action_just_released("ui_right"):
		stop_walk_animation()

	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func play_walk_animation():
	var modo_actual = modos[current_mode]
	animated_sprite.play(modo_actual["walk"])

func stop_walk_animation():
	var modo_actual = modos[current_mode]
	animated_sprite.play_backwards(modo_actual["walk"])

func play_jump_animation():
	var modo_actual = modos[current_mode]
	animated_sprite.play(modo_actual["jump"])

func play_habilidad_animation():
	var modo_actual = modos[current_mode]
	animated_sprite.play(modo_actual["habilidad"])
	
func cambiar_modo(op):
	if cooldown_cambio_personaje.is_stopped():
		cooldown_cambio_personaje.start()
		current_mode = op
		$transformacion/AnimationPlayer.play("change")
		match op:
			0:
				collision.scale.y = 1.5
				sprite.hframes = 9
				sprite.offset.y = -330
			1:
				collision.scale.y = 1
				sprite.hframes = 8
				sprite.offset.y = -420
			2:
				collision.scale.y = 1.8
				sprite.hframes = 8
				sprite.offset.y = -300

		actualizar_modo()

func actualizar_modo():
	var modo_actual = modos[current_mode]
	sprite.texture = modo_actual["sprite"]

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_1:
			cambiar_modo(0)
		elif event.keycode == KEY_2:
			cambiar_modo(1)
		elif event.keycode == KEY_3:
			cambiar_modo(2)

func usar_habilidad():
	var modo_actual = modos[current_mode]
	if cooldown.is_stopped():
		cooldown.start()
		play_habilidad_animation()
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
	var new_flecha = flecha.instantiate()
	if sprite.flip_h:
		new_flecha.direccion = -1
	else:
		new_flecha.direccion = 1
	new_flecha.position = Vector2(position.x, position.y)
	get_tree().current_scene.add_child(new_flecha)

func _on_cooldown_timeout():
	cooldown.stop()


func _on_cooldown_cambio_personaje_timeout():
	cooldown_cambio_personaje.stop() # Replace with function body.
