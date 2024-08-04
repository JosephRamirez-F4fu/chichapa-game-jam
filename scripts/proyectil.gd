extends Area2D

const SPEED = 550
var direccion = 1.0
@onready var sprite = $Sprite2D

func _ready():
	self.add_to_group("proyectil")
	$Timer.start()
	if direccion == 1:
		sprite.flip_h = false
	elif direccion == -1:
		sprite.flip_h = true

func _process(delta):
	position.x += SPEED*delta*direccion



func _on_timer_timeout():
	queue_free() # Replace with function body.
