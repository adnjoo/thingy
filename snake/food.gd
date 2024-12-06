extends Node2D

@export var grid_size = 16  # Match the snake's grid size

func _ready():
	randomize_position()

func randomize_position():
	# Set a random position within the grid
	position = Vector2(
		randf_range(0, 40) * grid_size,  # Adjust range to your game area
		randf_range(0, 30) * grid_size
	)
