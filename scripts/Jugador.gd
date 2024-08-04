extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


enum Modo {
	FLECHERO,
	MAGO,
	TANQUE,
}

<<<<<<< HEAD
=======
signal update_personaje
signal muerte

>>>>>>> ea2e24ca3107a0e8c497086c69c6dea2acdd3070
@onready var animated_sprite = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var collision = $CollisionShape2D
@onready var cooldown = $cooldown
@onready var cooldown_cambio_personaje = $cooldown_cambio_personaje
<<<<<<< HEAD
=======
@onready var change = $transformacion
 
>>>>>>> ea2e24ca3107a0e8c497086c69c6dea2acdd3070
var flecha = preload("res://proyectil.tscn")

var current_mode := Modo.FLECHERO

var modos := {
	Modo.TANQUE: {
		"jump": "tanque_jump",
		"walk": "tanque_walk",
		"habilidad": "tanque_habilidad",
<<<<<<< HEAD
=======
		"muerte": "tanque_muerte",
>>>>>>> ea2e24ca3107a0e8c497086c69c6dea2acdd3070
		"sprite": preload("res://assets/jugador/tanque/tanque.png")
	},
	Modo.MAGO: {
		"jump": "mago_jump",
		"walk": "mago_walk",
		"habilidad": "mago_habilidad",
<<<<<<< HEAD
=======
		"muerte": "mago_muerte",
>>>>>>> ea2e24ca3107a0e8c497086c69c6dea2acdd3070
		"sprite": preload("res://assets/jugador/curador/curador.png")
	},
	Modo.FLECHERO: {
		"jump": "flechero_jump",
		"walk": "flechero_walk",
		"habilidad": "flechero_habilidad",
<<<<<<< HEAD
=======
		"muerte": "flechero_muerte",
>>>>>>> ea2e24ca3107a0e8c497086c69c6dea2acdd3070
		"sprite": preload("res://assets/jugador/flechero/arquero.png")
	}
}

func _ready():
<<<<<<< HEAD
	add_to_group("Jugador")
	cambiar_modo(0)
=======
	cambiar_modo(0)
	self.add_to_group("Jugador")
>>>>>>> ea2e24ca3107a0e8c497086c69c6dea2acdd3070

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
<<<<<<< HEAD
=======

func play_muerte_animation():
	var modo_actual = modos[current_mode]
	animated_sprite.play(modo_actual["muerte"])
>>>>>>> ea2e24ca3107a0e8c497086c69c6dea2acdd3070
	
func cambiar_modo(op):
	if cooldown_cambio_personaje.is_stopped():
		cooldown_cambio_personaje.start()
		current_mode = op
<<<<<<< HEAD
		match op:
			0:
				collision.scale.y = 1.5
=======
		$transformacion/AnimationPlayer.play("change")
		match op:
			0:
				collision.scale.y = 1.5
				$Area2D/CollisionShape2D.scale.y = 1
>>>>>>> ea2e24ca3107a0e8c497086c69c6dea2acdd3070
				sprite.hframes = 9
				sprite.offset.y = -330
			1:
				collision.scale.y = 1
<<<<<<< HEAD
=======
				$Area2D/CollisionShape2D.scale.y = 0.6
>>>>>>> ea2e24ca3107a0e8c497086c69c6dea2acdd3070
				sprite.hframes = 8
				sprite.offset.y = -420
			2:
				collision.scale.y = 1.8
<<<<<<< HEAD
				sprite.hframes = 8
				sprite.offset.y = -300

		actualizar_modo()

func actualizar_modo():
=======
				$Area2D/CollisionShape2D.scale.y = 1.3
				sprite.hframes = 8
				sprite.offset.y = -300

		actualizar_modo(op)

func actualizar_modo(op):
>>>>>>> ea2e24ca3107a0e8c497086c69c6dea2acdd3070
	var modo_actual = modos[current_mode]
	sprite.texture = modo_actual["sprite"]
	_on_tiempo_escudo_timeout()
	_on_tiempo_aura_timeout()
	$CambioPersonaje.play()
	update_personaje.emit(op)

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_1:
			cambiar_modo(0)
		elif event.keycode == KEY_2:
			cambiar_modo(1)
		elif event.keycode == KEY_3:
			cambiar_modo(2)

func usar_habilidad():
<<<<<<< HEAD
	var modo_actual = modos[current_mode]
	if cooldown.is_stopped():
		cooldown.start()
		play_habilidad_animation()
=======
	if cooldown.is_stopped():
		cooldown.start()
>>>>>>> ea2e24ca3107a0e8c497086c69c6dea2acdd3070
		match current_mode:
			Modo.TANQUE:
				habilidad_tanque()
			Modo.MAGO:
				habilidad_mago()
			Modo.FLECHERO:
<<<<<<< HEAD
				habilidad_flechero()
=======
				play_habilidad_animation()
				habilidad_flechero()
				
>>>>>>> ea2e24ca3107a0e8c497086c69c6dea2acdd3070

func habilidad_tanque():
	if $escudo/TiempoEscudo.is_stopped():
		$escudo/TiempoEscudo.start()
		$escudo.visible = true
		$escudo/AnimationEscudo.play("proteger")

func habilidad_mago():
	if $aura/TiempoAura.is_stopped():
		$aura/TiempoAura.start()
		$aura.visible = true
		$aura/AnimationAura.play("aura")
		$aura/AudioStreamPlayer.play()
		get_tree().get_nodes_in_group("barra_vida_player")[0].aumentarVida(20)

func habilidad_flechero():
	var new_flecha = flecha.instantiate()
	if sprite.flip_h:
		new_flecha.direccion = -1
	else:
		new_flecha.direccion = 1
	new_flecha.position = Vector2(position.x, position.y)
	get_tree().current_scene.add_child(new_flecha)
<<<<<<< HEAD
=======
	$ataque_flecha.play()
>>>>>>> ea2e24ca3107a0e8c497086c69c6dea2acdd3070

func _on_cooldown_timeout():
	cooldown.stop()


func _on_cooldown_cambio_personaje_timeout():
	cooldown_cambio_personaje.stop() # Replace with function body.
<<<<<<< HEAD
=======

func _on_tiempo_escudo_timeout():
	$escudo/TiempoEscudo.stop() # Replace with function body.
	$escudo/AnimationEscudo.play_backwards("proteger")
	$escudo.visible = false

func _on_tiempo_aura_timeout():
	$aura/TiempoAura.stop()
	$aura.visible = false
	$aura/AudioStreamPlayer.stop()


func take_damage(amount):
	$hit.play()
	get_tree().get_nodes_in_group("barra_vida_player")[0].disminuirVida(amount)
	if get_tree().get_nodes_in_group("barra_vida_player")[0].get_vida() <= 0:
		die()

func die():
	muerte.emit()
	$derrota.play()
	set_physics_process(false)
	play_muerte_animation()
	await (animated_sprite.animation_finished)
	_restart_scene()

func _restart_scene() -> void:
	get_tree().reload_current_scene()

func _on_area_2d_body_entered(body):
	if body.is_in_group("enemigo") and $escudo/TiempoEscudo.is_stopped():
		take_damage(21)
>>>>>>> ea2e24ca3107a0e8c497086c69c6dea2acdd3070
