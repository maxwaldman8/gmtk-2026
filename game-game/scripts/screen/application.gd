extends Control

var connected_window_name : String
var is_opened : bool = false


# on double tap:
	# not is_opened: open window by connected window name
	# is_opened: have window scale animation, go to front
