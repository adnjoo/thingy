extends Node2D

@export var speed = 4  # Movement speed
@export var grid_size = 16  # Grid-based movement

var direction = Vector2.RIGHT  # Current movement direction
var segments = []  # Holds all snake body parts
var grow = false  # Whether to grow after eating

func _ready():
	# Initialize the snake with one segment
	segments.append(create_segment(position))

func _process(delta):
	move_snake()

func move_snake():
	# Calculate the next position
	var next_position = position + direction * grid_size

	# Check for collisions (self or boundaries)
	if check_collision(next_position):
		get_tree().reload_current_scene()
		return

	# Move the snake
	if not grow:
		var tail = segments.pop_back()
		tail.position = next_position
		segments.insert(0, tail)
	else:
		grow = false
		segments.insert(0, create_segment(next_position))

	position = next_position

func create_segment(position: Vector2) -> Node2D:
	# Create a new snake segment
	var segment = Node2D.new()
	segment.position = position
	add_child(segment)
	return segment

func check_collision(next_position: Vector2) -> bool:
	# Check if the snake collides with itself
	for segment in segments:
		if segment.position == next_position:
			return true
	return false

func grow_snake():
	grow = true

func _input(event):
	if event.is_action_pressed("move_up") and direction != Vector2.DOWN:
		direction = Vector2.UP
	elif event.is_action_pressed("move_down") and direction != Vector2.UP:
		direction = Vector2.DOWN
	elif event.is_action_pressed("move_left") and direction != Vector2.RIGHT:
		direction = Vector2.LEFT
	elif event.is_action_pressed("move_right") and direction != Vector2.LEFT:
		direction = Vector2.RIGHT
