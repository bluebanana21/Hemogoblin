extends CharacterBody2D


@export var SPEED: float = 300.0
@onready var blood_timer: Timer = $BloodTimer
@onready var player_collision: CollisionShape2D = $CollisionShape2D

var bullet = preload("res://scenes/bullet.tscn")

var knockback:Vector2 = Vector2.ZERO
var knockback_timer:float = 0.2
#var num_of_blood_splatters: Array[Node] = get_tree().get_nodes_in_group("blood splatters")
var num_of_blood_splatters:int
var health:int = 100
var blood_ammo: int = 10

var absorbed_blood_in_secs:float = 0.0

var is_absorbing_blood:bool = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot") and blood_ammo > 0:
		print("blood ammo: ", blood_ammo)
		shoot()
	
	if Input.is_action_pressed("absorb_blood") and num_of_blood_splatters > 0:
		is_absorbing_blood = true
		absorbed_blood_in_secs = 0.0
		blood_timer.start()
	
	elif Input.is_action_just_released("absorb_blood"):
		is_absorbing_blood = false
		print("absorbed blood for ", absorbed_blood_in_secs, " secs")
		print("time left ", blood_timer.time_left)
	
	if event.is_action_pressed("get_info"):
		print("number of blood splatters ", num_of_blood_splatters)


func _process(delta: float) -> void:
	if is_absorbing_blood:
		blood_timer.wait_time + 1.0


func _physics_process(delta: float) -> void:
	if is_absorbing_blood:
		return
	
	look_at(get_global_mouse_position())
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("left", "right", "up", "down")
	
	if direction:
		velocity = direction * (SPEED * 5) * delta
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	if knockback_timer > 0.0:
		velocity = knockback
		knockback_timer -= delta
		if knockback_timer <= 0.0:
			knockback = Vector2.ZERO
	
		
	move_and_slide()


func shoot():
	print("shoot")
	blood_ammo -= 1
	var bullet_instance = bullet.instantiate()
	bullet_instance.global_position = global_position
	bullet_instance.direction = (get_global_mouse_position() - global_position).normalized()
	$/root/MainWorld.add_child(bullet_instance)


func apply_knockback(direction:Vector2, force:float, knockback_duration: float)->void:
	knockback = direction * force
	knockback_timer = knockback_duration


func _on_blood_timer_timeout() -> void:
	absorbed_blood_in_secs += 1.0


func _on_blood_detection_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("blood splatters"):
		print("blooooooooood")
		num_of_blood_splatters += 1


func _on_blood_detection_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("blood splatters"):
		num_of_blood_splatters -= 1
