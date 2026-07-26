class_name AssignmentsData
extends Resource

# Each assignment tab has a name, class, color, due date
# Each assignment page has a description (submission details based on if submitted or not)

static var d : Dictionary = {
	"tutorial": [
		"Worksheet 1.1", "Math", Color(0.446, 0.574, 0.921, 1.0), load("res://sprites/screen/classicons/classicons00.png"), "11:49", 
		"Upload your math homework.\nDrag the file into the slot to upload it."
	],
	"conversion": [
		"Speech Final Draft", "Public Speaking", Color(0.901, 0.208, 0.471, 1.0), load("res://sprites/screen/classicons/classicons01.png"), "11:51", 
		"Submit your speech!\nSubmission type: PDF ONLY"
	],
	"message_3d": [
		"Chemistry Group Project", "Science", Color(0.64, 0.377, 0.868, 1.0), load("res://sprites/screen/classicons/classicons02.png"), "11:52", 
		"All groups must have everyone submit their data. Please ask your partner for it if you don't have it."
	],
	"question_video": [
		"Watch Space Invaders Video", "Game Design with Mark Brown", Color(0.342, 0.357, 0.335, 1.0), load("res://sprites/screen/classicons/classicons03.png"), "11:53", 
		"Please go to gtkm.com to download the video.\nSubmit the video file when you are done watching it."
	],
	"pop_up": [
		"Poster Submission", "Graphic Design", Color(0.069, 0.607, 0.609, 1.0), load("res://sprites/screen/classicons/classicons04.png"), "11:54", 
		"Submit your advertisement poster here."
	],
	"movie_ads": [
		"Watch Vampire Movie", "Film-making", Color(0.946, 0.702, 0.251, 1.0), load("res://sprites/screen/classicons/classicons05.png"), "11:55", 
		"Finish this movie (download at bestfilms.net), no other homework. Submit the video file when you're done (you can skip past the ads with well-timed arrow key presses)."
	],
	"image_puzzle_and_cat": [
		"English Family Member Essay", "English", Color(0.284, 0.695, 0.519, 1.0), load("res://sprites/screen/classicons/classicons06.png"), "11:56", 
		"Please ensure that you download the document from the proper website."
	],
	"task_invaders": [
		"Final History Project", "History", Color(0.913, 0.456, 0.29, 1.0), load("res://sprites/screen/classicons/classicons07.png"), "11:59", 
		"Please submit your project report here."
	],
	"wallpaper": [
		"Ensayo de Miembros de Familia", "Spanish", Color(0.91, 0.247, 0.24, 1.0), load("res://sprites/screen/classicons/classicons08.png"), "11:59", 
		"Please ensure that you download the document from the proper website."
	],
	"alarm_clock": [
		"Depth First Search Program", "Programming", Color(0.172, 0.578, 0.695, 1.0), load("res://sprites/screen/classicons/classicons09.png"), "11:59", 
		"Retrieve your code (dfs.java) from your flash drive and submit it here."
	]
}
