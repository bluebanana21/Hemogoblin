extends CharacterBody2D


@export var SPEED: float = 300.0

var blood_ammo: int = 10
var absorbed_blood:int = 0
var bullet = preload("res://scenes/bullet.tscn")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot") and blood_ammo > 0:
		print("blood ammo: ", blood_ammo)
		shoot()
	


func _process(delta: float) -> void:
	if Input.is_action_pressed("absorb_blood"):
		absorbed_blood += 1 * delta
	
	if Input.is_action_just_released("absorb_blood"):
		absorbed_blood = 0
	
	if  absorbed_blood > 0:
		pass
	print("absorbed blood for ", absorbed_blood, " seconds")
	


func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("left", "right", "up", "down")
	
	if direction:
		velocity = direction * (SPEED * 5) * delta
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	#print(velocity)
	move_and_slide()


func shoot():
	print("shoot")
	blood_ammo -= 1
	var bullet_instance = bullet.instantiate()
	bullet_instance.global_position = global_position
	bullet_instance.direction = (get_global_mouse_position() - global_position).normalized()
	$/root/MainWorld.add_child(bullet_instance)
