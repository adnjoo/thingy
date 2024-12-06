extends Node2D

@onready var snake = $Snake
@onready var food = $Food
@onready var score_label = $UI/ScoreLabel

var score = 0

func _process(delta):
	check_food_collision()

func check_food_collision():
	# Check if the snake's head collides with the food
	if snake.position == food.position:
		snake.grow_snake()
		food.randomize_position()
		update_score()

func update_score():
	score += 1
	score_label.text = "Score: %d" % score
