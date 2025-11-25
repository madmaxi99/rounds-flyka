extends CollisionPolygon2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_polygon($"..".get_parent().polygon)
	global_position = $"..".get_parent().global_position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
