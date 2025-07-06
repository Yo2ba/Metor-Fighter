extends Node

signal new_text(text: String)
signal noclip
signal showfps(OnOff)
var commands_list: Array[String] = ['showfps','admin_cheats','noclip','platform']

var console_text_display:
	set(value):
		console_text_display = value
		if typeof(console_text_display) == TYPE_ARRAY:
			var joined = "".join(console_text_display)
			new_text.emit(joined)
		else:
			new_text.emit(console_text_display)
			

var cheats: bool = false:
	set(value):
		cheats = value
		var on_off: String
		on_off = 'ON' if cheats == true else 'OFF'
		print('cheats ',on_off)
		console_text_display = ['cheats ',str(on_off)]
var command_history: Array = ['blank']
var command_togglable: Array[String] = ['0','1']

var command:
	set(value):
		if command_history.size() == 1:
			command_history.insert(1,value)
		elif command_history[1] != value:
			command_history.insert(1,value)
		command = Array(value.split(' '))
		if commands_list.has(command[0]) == false:
			unknown_command()
		else:
			match command[0]:
				'showfps':
					if command.size() == 1:
						unknown_value('null')
					else:
						if command_togglable.has(command[1]):
							showfps.emit(command[1])
							print(command[0],' ',command[1])
							console_text_display = [str(command[0]),' ',str(command[1])]
						else:
							unknown_value(command[1])
				'admin_cheats':
					if command.size() == 1:
						unknown_value('null')
					else:
						if command_togglable.has(command[1]):
							cheats = true if command[1] == '1' else false
						else:
							unknown_value(command[1])
				'noclip':
					if not cheats:
						unknown_command()
					else:
						if command.size() != 1:
							unknown_value(command[1])
						else:
							noclip.emit()
				'platform':
					console_text_display = str('Platform name: ',Platform.platform)

func unknown_value(value):
	print('Unknown value for ',command[0],': ',value)
	console_text_display = ['Unknown value for ',str(command[0]),': ',str(value)]

func unknown_command():
	print('Unknown command: ',command[0])
	console_text_display = ['Unknown command: ',str(command[0])]
