extends CharacterBody2D


var SPEED = 40
var range = 400
var original_position

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready():
	original_position = position.x

func movimiento(delta):
	if position.x > original_position+range:
		SPEED = SPEED*-1
	elif position.x < original_position-range:
		SPEED = SPEED*-1
		
	if SPEED < 0 : 
		$Sprite2D.flip_h = 0
	elif SPEED > 0 : 
		$Sprite2D.flip_h = 1
		
	$AnimationPlayer.play("move")
	position.x = position.x + SPEED*delta
	
func _process(delta):
	movimiento(delta)
