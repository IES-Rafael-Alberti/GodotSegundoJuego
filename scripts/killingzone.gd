extends Area2D

@onready var timer: Timer = $Timer
@onready var die_sound: AudioStreamPlayer2D = $Die_Sound

func _on_body_entered(body: Node2D) -> void:
	print("Die")
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").queue_free()
	die_sound.play()
	timer.start()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
