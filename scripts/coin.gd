extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var shape: CollisionShape2D = $CollisionShape2D
var hud: Node = null

func _ready() -> void:
	hud = get_tree().get_first_node_in_group("hud")

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return
	if hud == null:
		hud = get_tree().get_first_node_in_group("hud")
	if hud:
		hud.add_coin()
	shape.set_deferred("disabled", true)
	animation_player.play("pickup")

func _on_AnimationPlayer_animation_finished(anim_name: StringName) -> void:
	if anim_name == "pickup":
		queue_free()
