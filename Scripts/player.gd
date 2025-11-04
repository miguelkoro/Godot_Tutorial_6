extends CharacterBody2D

@export var speed:float = 40
@onready var animation_tree: AnimationTree = $AnimationTree


func _physics_process(delta: float) -> void:
	var input_dir := Input.get_vector("ui_left", "ui_right","ui_up", "ui_down")
	var direction := input_dir.normalized()

	if direction:
		velocity = direction * speed * delta
		animation_tree.set("parameters/blend_position", direction)
		
	else:
		velocity = Vector2.ZERO
		
	move_and_slide()
