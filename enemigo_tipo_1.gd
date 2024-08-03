extends CharacterBody2D


var SPEED = 2
const JUMP_VELOCITY = -400.0
var range = 100
var original_position

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready():
	original_position = position.x

func movimiento():
	if position.x > original_position+range:
		SPEED = SPEED*-1
	elif position.x < original_position-range:
		SPEED = SPEED*-1
	position.x = position.x + SPEED
	
func _process(delta):
	movimiento()
