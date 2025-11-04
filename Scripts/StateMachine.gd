class_name StateMachine
extends Node

# Emitted when transitioning to a new state.
signal transitioned(state_name)

@export var initial_state := NodePath()
@onready var state: State = get_node(initial_state)

func _ready() -> void:
	#Similar to parent.ready. This will wait until its creator/parent is ready.
	await owner.ready
	for child in get_children():
		child.state_machine = self
	state.enter()

#Same as _input, but executed after UI. It recieves unhandled by the UI inputs.
func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)

func _process(delta: float) -> void:
	state.update(delta)

func _physics_process(delta: float) -> void:
	state.physics_update(delta)

func transition_to(target_state_name: String, msg: Dictionary = {}) -> void:
	if not has_node(target_state_name):
		return

	state.exit()
	state = get_node(target_state_name)
	state.enter(msg)
	emit_signal("transitioned", state.name)
