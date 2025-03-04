## Finite state machine
class_name StateMachine extends Node

var object : Node
var states = {}
var previous_state : State
var next_state : State
var current_state : State
var debug : bool

func _init(object, state_holder, initial_state, debug=false):
	self.object = object
	self.debug = debug
	setup_states(state_holder)
	self.next_state = initial_state

func setup_states(state_holder):
	for state in state_holder.get_children():
		states[state.name] = state
		state.setup(self, object)

func process(delta):
	if next_state != current_state:
		if current_state != null:
			current_state.exit(next_state)
			if debug:
				print('Exited %s' % current_state.name)
			previous_state = current_state
		current_state = next_state
		current_state.enter(previous_state)
		if debug:
			print('Entered %s' % current_state.name)
	current_state.process(delta)
	
func process_physics(delta):
	if current_state != null:
		current_state.process_physics(delta)
