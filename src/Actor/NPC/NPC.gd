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


func _input(event):
	if event is InputEventMouseButton:
		_mouse_target = event.position


func _physics_process(delta):
	if _target:
		var dir = get_direction(_target)
		move_and_slide(dir * speed)
	else:
		_target = get_target(mode)


func get_target(current_mode: int) -> Vector2:
	var target = Vector2.ZERO
	
	if current_mode == MODE.MOUSE_FOLLOW:
		target = _mouse_target
	elif current_mode == MODE.RANDOM_MOVE:
		$MoveResetTimer.start()
		target = Vector2(rand_range(x_min, x_max), rand_range(y_min, y_max))
		
	return target


func get_direction(target: Vector2) -> Vector2:
	var current_loc = global_position
	var direction = target.direction_to(target)
	return direction


func _on_MoveResetTimer_timeout():
	_target = Vector2.ZERO
