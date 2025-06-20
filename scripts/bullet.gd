extends Area2D

var direction:Vector2
@export var bullet_speed:float = 200.0
var blood_splatter = preload("res://scenes/blood_splatter.tscn")


func _physics_process(delta: float) -> void:
	global_position += direction * bullet_speed * delta


func _on_timer_timeout() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		var blood_splatter_instance = blood_splatter.instantiate()
		blood_splatter_instance.global_position = global_position
		$/root/MainWorld.add_child(blood_splatter_instance)
		body.queue_free()
		queue_free()
