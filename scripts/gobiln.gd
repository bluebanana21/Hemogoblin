extends CharacterBody2D

@export var speed:float = 200.0
@onready var player = get_node("/root/MainWorld/Player")

@export var knockback_power: int = 1

func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * (speed * 2) * delta
	move_and_slide()


func _on_tree_exited() -> void:
	print("enemy has died")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("knockback player")
		var knockback_direction = (body.global_position - global_position).normalized()
		body.apply_knockback(knockback_direction, 150.0, 0.12)
