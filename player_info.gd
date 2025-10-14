extends CanvasLayer

var coins := 0
@onready var coins_label: Label = $CoinsCount/CoinsLabel

func _ready() -> void:
	add_to_group("hud")
	update_display()

func add_coin() -> void:
	coins += 1
	update_display()

func update_display() -> void:
	coins_label.text = str(coins)        # el Label necesita String
