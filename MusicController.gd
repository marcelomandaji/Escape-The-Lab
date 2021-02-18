extends Node

var intro_music = load("res://Assets/Audio/escape_the_lab_intro.wav")
var theme_music = load("res://Assets/Audio/escape_the_lab_main_theme.wav")
var final_music = load("res://Assets/Audio/escape_the_lab_final.wav")

var key_sfx = load("res://Assets/Audio/key.wav")
var jump_sfx = load("res://Assets/Audio/jump.wav")
var clone_sfx = load("res://Assets/Audio/clone.wav")
var fall_sfx = load("res://Assets/Audio/jump_fall.wav")

func _ready():
	$Music.set_volume_db(-8)
	$Sfx.set_volume_db(-2)
	
func play_intro():
	$Music.stream = intro_music
	$Music.play()

func play_theme():
	$Music.stream = theme_music
	$Music.play()

func play_final():
	$Music.stream = final_music
	$Music.play()
	
func sfx_key():
	$Sfx.stream = key_sfx
	$Sfx.play()
	
func sfx_jump():
	$Sfx.stream = jump_sfx
	$Sfx.play()
	
func sfx_clone():
	$Sfx.stream = clone_sfx
	$Sfx.play()
	
func sfx_fall():
	$Sfx.stream = fall_sfx
	$Sfx.play()
