extends Node

var active_music_stream : AudioStreamPlayer
var last_stop_position: float = 0.0 
var tracked_song_name: String = ""  


@export var clips : Node
@export var oneshots : Node
@export var audio_oneshot_scene : PackedScene

var max_sounds = 6
var current_sounds = 0

# For music - add song track to a node in Audio Manager tree - ensures music plays over scenes
func play(audio_name: String, from_position: float = 0.0) -> void:
	if active_music_stream:
		if active_music_stream.name == audio_name:
			return
		last_stop_position = active_music_stream.get_playback_position()
		tracked_song_name = active_music_stream.name
		active_music_stream.stop()
	active_music_stream = clips.get_node(audio_name)
	active_music_stream.bus = "Music"
	active_music_stream.play(from_position)

func stop(audio_name: String) -> void:
	var target = clips.get_node(audio_name)
	if active_music_stream and active_music_stream.playing:
		last_stop_position = target.get_playback_position()
		tracked_song_name = target.name
		target.stop()
	if target == active_music_stream:
		active_music_stream = null
	
func resume() -> void :
	if active_music_stream and tracked_song_name ==active_music_stream.name:
		active_music_stream.play(last_stop_position)
		

# For sound fx - connect sound via export var on node calling function
func play_audio_oneshot(audio_stream: AudioStream, volume_db : float = 0.0, from_position : float = 0.0) -> AudioOneshot:
	
	var audio_oneshot : AudioOneshot = audio_oneshot_scene.instantiate()
	audio_oneshot.stream = audio_stream
	audio_oneshot.volume_db = volume_db
	audio_oneshot.from_position = from_position
	audio_oneshot.bus = "SFX"
	
	audio_oneshot.finished.connect(on_oneshot_finished)
	current_sounds += 1
	oneshots.add_child(audio_oneshot)
	return audio_oneshot

func stop_all_sfx() -> void:
	for oneshot in oneshots.get_children():
		oneshot.stop()

func on_oneshot_finished() -> void:
	current_sounds -= 1
