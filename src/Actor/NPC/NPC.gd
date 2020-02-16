extends KinematicBody2D

enum MODE{MOUSE_FOLLOW, RANDOM_MOVE}

export var speed: = 200.0
export(MODE) var mode: = MODE.MOUSE_FOLLOW
export var x_min: = 0
export var x_max: = 800
export var y_min: = 0
export var y_max: = 600

var _target: = Vector2.ZERO
var _mouse_target: = Vector2.ZERO


func _on_MoveResetTimer_timeout():
	_target = Vector2.ZERO


func _input(event):
	if event is InputEventMouseButton:
		_target = Vector2.ZERO
		_mouse_target = event.position


func _physics_process(delta):
	var direction = Vector2.ZERO
	if _target:
		direction = get_direction(_target)
		move_and_slide(direction * speed)
	else:
		_target = get_target(mode)
	animate_move(direction)


func get_target(current_mode: int) -> Vector2:
	var target = Vector2.ZERO
	
	if current_mode == MODE.MOUSE_FOLLOW:
		target = _mouse_target
	elif current_mode == MODE.RANDOM_MOVE:
		$MoveResetTimer.start()
		target = Vector2(rand_range(x_min, x_max), rand_range(y_min, y_max))
	
	return target


func get_direction(target: Vector2) -> Vector2:
	return global_position.direction_to(target)


func animate_move(direction: Vector2) -> void:
	if direction.y >= 0.707:
		$NPCAnimations.play("walk_down")
	elif direction.y <= -0.707:
		$NPCAnimations.play("walk_up")
	elif direction.x >= 0.707:
		$NPCAnimations.play("walk_right")
	elif direction.x <= -0.707:
		$NPCAnimations.play("walk_left")
	else:
		$NPCAnimations.stop()
