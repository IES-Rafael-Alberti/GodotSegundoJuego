extends Sprite2D

var velocity = Vector2(150, -200)
var gravity = 9.8

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity.y += gravity
	position += velocity * delta
