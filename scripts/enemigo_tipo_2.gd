extends CharacterBody2D


<<<<<<< HEAD
const SPEED = 2
var move = Vector2.ZERO
var jugador = null
=======
var vida = 3
var speed = 80.0
const SPEED_PERSEGUIR = 200
const JUMP_VELOCITY = -400.0
>>>>>>> ea2e24ca3107a0e8c497086c69c6dea2acdd3070

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var persiguir: bool = false

func _ready():
	velocity.x = -speed

func _physics_process(delta):
<<<<<<< HEAD
	move = Vector2.ZERO
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if jugador != null:
		move = position.direction_to(jugador.position)
	
	else:
		move = Vector2.ZERO
		
	move = move.normalized()*SPEED
	move = move_and_collide(move)

=======
	detect()
	if not is_on_floor():
		velocity.y += gravity * delta
	if !persiguir:
		$AnimationPlayer.play("move")
		if is_on_wall():
			if !$Sprite2D.flip_h:
				velocity.x = speed
			else:
				velocity.x = -speed
		if velocity.x < 0:
			$Sprite2D.flip_h = false
		elif velocity.x > 0:
			$Sprite2D.flip_h = true
>>>>>>> ea2e24ca3107a0e8c497086c69c6dea2acdd3070
	move_and_slide()

func detect():
	if $right.is_colliding():
		var obj = $right.get_collider()
		if obj.is_in_group("Jugador"):
			persiguir = true
			$AnimationPlayer.play("rotar")
			velocity.x = SPEED_PERSEGUIR
			$Sprite2D.flip_h = true
		else:
			persiguir = false
			$AnimationPlayer.play("move")
	
	if $left.is_colliding():
		var obj = $left.get_collider()
		if obj.is_in_group("Jugador"):
			persiguir = true
			$AnimationPlayer.play("rotar")
			velocity.x = -SPEED_PERSEGUIR
			$Sprite2D.flip_h = false
		else:
			persiguir = false
			$AnimationPlayer.play("move")


func _on_area_2d_body_entered(body):
<<<<<<< HEAD
	if body != self and body.is_in_group("Jugador"):
		jugador = body



func _on_area_2d_body_exited(body):
	jugador = null # Replace with function body.
=======
	if body.is_in_group("personaje"):
		body.take_damage(15)
>>>>>>> ea2e24ca3107a0e8c497086c69c6dea2acdd3070
