extends Node2D

const SPEED = 60

var direction = 1

# RayCast for movement
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_floor_right: RayCast2D = $RayCastFloorRight
@onready var ray_cast_floor_left: RayCast2D = $RayCastFloorLeft

# Audio
@onready var die_slime: AudioStreamPlayer2D = $Die_Slime

# Slime Animated
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ray_cast_right.is_colliding() or not ray_cast_floor_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	if ray_cast_left.is_colliding() or not ray_cast_floor_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
	
	position.x += direction * SPEED * delta

func _on_killingzone_area_entered(area: Area2D) -> void:
	$AnimatedSprite.play("die")
	die_slime.play()

func _on_animated_sprite_animation_finished() -> void:
	self.queue_free()
