extends Area3D

@onready var ending_screen: CanvasLayer = get_node("/root/Main/EndingScreen")

func _ready() -> void:
	# Connect the signal when something enters the area
	self.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	get_parent().get_node('EndingScreen').show()
	get_tree().paused = true     # Optional: pause the game when ending screen shows
