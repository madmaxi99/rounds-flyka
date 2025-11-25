extends CharacterBody2D

const WEIGHT = 1.5
const SPEED = 300.0
const JUMP_VELOCITY = -500.0
var bullet_speed = 1000
var airtime:float = 0
@export var bullet: PackedScene



func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		fire()

func _physics_process(delta: float) -> void:
	velocity -= 0.3*velocity * delta
	# Add the gravity.
	if not is_on_floor():
		airtime += delta
		if is_on_wall():
			velocity += get_gravity() * delta * WEIGHT
		else:
			velocity += get_gravity() * delta * WEIGHT
	else: airtime = 0

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_pressed("jump") and is_on_wall():
		velocity.y = 2*JUMP_VELOCITY/3
	
	if not is_on_floor() and Input.is_action_pressed("down"):
		velocity += delta*Vector2(0,4000)
	
	if not is_on_floor() and Input.is_action_pressed("jump"):
		if airtime <= 20: velocity -= delta*Vector2(0,600)
		velocity -= delta*Vector2(0,400)
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction and velocity.x < SPEED and -SPEED < velocity.x:
		velocity.x += delta * direction * SPEED * 10
	else:
		if velocity.x != 0 and is_on_floor(): velocity.x -= velocity.x/5
		else: if velocity.x != 0: velocity.x -= velocity.x/50
		

	move_and_slide()

func fire():
	var b = bullet.instantiate()
	b.global_position = $CenterpointGun/Gun/GunPosition.global_position
	b.global_rotation = $CenterpointGun/Gun/GunPosition.global_rotation
	b.set_velocity(bullet_speed*Vector2($CenterpointGun/Gun/GunPosition.global_position - $".".global_position).normalized())
	b.shooter = $"."
	#print($GunRotation/BulletSpawn.rotation)
	get_tree().root.add_child(b)
