extends CharacterBody2D

const WEIGHT = 1
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var bullet_speed = 1000
@export var bullet: PackedScene




func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		fire()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		if is_on_wall():
			velocity += get_gravity() * delta * WEIGHT
		else:
			velocity += get_gravity() * delta * WEIGHT

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func fire():
	var b = bullet.instantiate()
	b.global_position = $CenterpointGun/Gun/GunPosition.global_position
	b.global_rotation = $CenterpointGun/Gun/GunPosition.global_rotation
	b.set_velocity(bullet_speed*Vector2($CenterpointGun/Gun/GunPosition.global_position - $".".global_position).normalized())
	b.shooter = $"."
	#print($GunRotation/BulletSpawn.rotation)
	get_tree().root.add_child(b)
