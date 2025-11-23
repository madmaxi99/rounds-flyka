extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (get_viewport().get_mouse_position().x < global_position.x):
		$Gun.flip_v = true
	else:
		$Gun.flip_v = false
	look_at(get_viewport().get_mouse_position())
	pass
