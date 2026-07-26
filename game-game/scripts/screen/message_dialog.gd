class_name MessageDialog
extends Node


static func get_response_to(message: String):
	match message:
		"Hey Bob, you submitted the lab, right?", "Hi Bob, do you have the lab data?":
			return "What???? I thought you submitted it already?!! We have like a minute to submit!!"
		"Can you give it to me to upload?", "Ok, then send it to me please":
			return "Sure, here’s the file"
		"Ok, you can upload it?":
			return "Sure, but it says we both need to upload it"
		"Trust me, it’s fine":
			return "Ok, whatever you say then I guess"


static func get_options_to(message: String):
	match message:
		"":
			return ["Hey Bob, you submitted the lab, right?", "Hi Bob, do you have the lab data?"]
		"What???? I thought you submitted it already?!! We have like a minute to submit!!":
			return ["Can you give it to me to upload?", "Ok, you can upload it?"]
		"Sure, but it says we both need to upload it":
			return ["Ok, then send it to me please", "Trust me, it’s fine"]


static func is_good_end(message: String):
	return message == "Sure, here’s the file"


static func is_bad_end(message: String):
	return message == "Ok, whatever you say then I guess"
