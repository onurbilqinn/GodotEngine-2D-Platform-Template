extends KinematicBody2D

var gravity = 100
var jump = 1500

var velocity = Vector2.ZERO
var direction = 0

var max_speed = 350
var acceleration = 1500
var friction = 0.2

onready var sprite = get_node("Sprite")


func _physics_process(_delta):
	direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if direction != 0:
		velocity.x = acceleration * direction
		velocity.x = clamp(velocity.x, -max_speed, max_speed)
	else:
		velocity.x = 0
		velocity.x = lerp(velocity.x, 0, friction)
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_select"):
			velocity.y += -jump
	
	animated_update()
	gravity_apply()
	velocity = move_and_slide(velocity, Vector2.UP)


func gravity_apply():
	velocity.y += gravity

func animated_update():
	if direction > 0:
		sprite.flip_h = false
	if direction < 0:
		sprite.flip_h = true

