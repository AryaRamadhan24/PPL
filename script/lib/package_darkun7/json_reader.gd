extends Node

var Helper = preload("res://script/lib/package_darkun7/json_helper.gd").new()

func starter():
	pass

### GENERIC JSON ###
func readJSON(path):
	var data
	var file = File.new()
	var target = Helper.path4(path)
	if not file.file_exists(target):
		print("OTW buat bos!")
		createJSON(path)
		pass
	
	file.open(target, File.READ)
	data = JSON.parse(file.get_as_text())
	file.close()
	return data.result

func pushJSON(key : Array, value : Array, path):
	var data
	var session = readJSON(path)
	print(session)
	for n in range(len(key)):
		session[key[n]] = value[n]
	saveJSON(session, path)
	return true

func appendJSON(value , path):
	var added = false
	var new_session = []
	var session     = readJSON(path)
	for n in session:
		if value[0] == n[0]:
			n[0] = value[0]
			n[value[1]] = value[2]
			added = true
		new_session.append(n)
	#if(!added):
	#	new_session.append([value[0],value[1]])
	saveJSON(new_session, path)
	return true

func saveJSON(data, path):
	var file = File.new()
	var target = Helper.path4(path)
	
	file.open(target, File.WRITE)
	file.store_line(JSON.print(data))
	file.close()
	return true

func createJSON(kind)->void:
	var data
	match kind:
		"pemain":
			data = Helper.get_pemain().duplicate(true)
			saveJSON(Helper.get_pemain(),"pemain")
		"score":
			data = Helper.get_score().duplicate(true)
			saveJSON(Helper.get_score(),"score")
	pass
