extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_jugador_update_personaje(op):
	match op:
		0:
			$HUD/Indicador.frame = 0
		1:
			$HUD/Indicador.frame = 2
		2:
			$HUD/Indicador.frame = 1



func _on_jugador_muerte():
	$fondo.stop() # Replace with function body.



func _on_fall_body_entered(body):
	print("a")
	if body.is_in_group("Jugador"):
		body.die()
