extends Area2D
signal hit

@export var speed = 400
@onready var collision = $CollisionShape2D
var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	
func _process(delta):
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		collision.scale.x = 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		collision.scale.x = -1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1  
		collision.scale.y = -1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1  
		collision.scale.y = 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
		if abs(velocity.x) > abs(velocity.y):
			if velocity.x > 0:
				$AnimatedSprite2D.play("Right")
			else:
				$AnimatedSprite2D.play("Left")
		else:
			if velocity.y > 0:
				$AnimatedSprite2D.play("Down")
			else:
				$AnimatedSprite2D.play("Up")
	else:
		$AnimatedSprite2D.stop()
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
func _on_body_entered(_body):
		hide()
		hit.emit()
		$CollisionShape2D.set_deferred("disabled", true)
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
