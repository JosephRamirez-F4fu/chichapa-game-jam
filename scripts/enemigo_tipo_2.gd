extends CharacterBody2D


const SPEED = 2
var move = Vector2.ZERO
var jugador = null

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
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

	move_and_slide()


func _on_area_2d_body_entered(body):
	if body != self and body.is_in_group("Jugador"):
		jugador = body



func _on_area_2d_body_exited(body):
	jugador = null # Replace with function body.
