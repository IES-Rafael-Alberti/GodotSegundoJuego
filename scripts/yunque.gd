extends Sprite2D

var velocity = Vector2(150, -200)
var gravity = 9.8

signal yunque_destroyed
var isFlip =false

func _ready() -> void:
	$Timer.start()
	if isFlip:
		velocity.x *= -1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity.y += gravity
	position += velocity * delta

func _on_hitbox_body_entered(body: Node2D) -> void:
	emit_signal("yunque_destroyed")
	velocity = Vector2 (0, 0)


func _on_timer_timeout() -> void:
	emit_signal("yunque_destroyed")
	self.queue_free()
