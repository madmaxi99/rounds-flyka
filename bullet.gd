extends CharacterBody2D
var bounces = 10000
var shooter
var damage = 10
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta):
	# Add the gravity.
	rotation = velocity.normalized().angle()
	
	if not is_on_floor():
		velocity.y += get_gravity().y * delta
		pass
	var collision_info = move_and_collide(velocity*delta)
	if collision_info:
		var collider = collision_info.get_collider()
		if collider != null && collider.has_method("fire"):
			#if collider.blocking >=1 :
			#	velocity = velocity.bounce(collision_info.get_normal())
			#else: if collider.blocking <=0:
			queue_free()
		else: if bounces == 0:
			queue_free()
		else: if bounces > 0 : 
			bounces-=1
			velocity = velocity.bounce(collision_info.get_normal())
		if collider.has_method("take_damage") :
			print("ouchd")
			collider.take_damage(damage)
	pass
