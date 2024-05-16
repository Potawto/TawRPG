class_name InfoBox
extends VBoxContainer

## When string contents but not labels changed (mutex v)
signal string_contents_changed
## When labels and string contents changed (mutex ^)
signal labels_changed

@export var child_h_alignmnent: HorizontalAlignment
@export var child_v_alignment: VerticalAlignment

var string_contents: Array[String]:
	set(value):
		string_contents = value
		string_contents_changed.emit()

var _child_labels: Array[Label] = []


func _ready() -> void:
	var children := get_children()
	_child_labels.resize(children.size())
	string_contents.resize(_child_labels.size())
	var i = 0
	for child in children:
		if child is Label:
			_child_labels[i] = child as Label
			string_contents[i] = child.text
			i += 1
	self.connect("string_contents_changed", _on_string_contents_changed)


func _process(_delta: float) -> void:
	if get_child_count() == 0 and get_parent().visible:
		get_parent().visible = false

## Returns old content of line or ""
func set_line(i: int, contents) -> String:
	var old_content;
	var new_content = str(contents)
	if string_contents.size() == 0:
		string_contents.append(new_content)
		_child_labels.append(_new_label(new_content))
		labels_changed.emit()
		return ""
	elif i < string_contents.size():
		old_content = string_contents[i]
		string_contents[i] = new_content
		_child_labels[i].text = new_content
		labels_changed.emit()
		return old_content
	else:
		string_contents.resize(i + 1)
		for j in range(_child_labels.size(), string_contents.size()):
			_child_labels.append(_new_label())
		string_contents[i] = new_content
		labels_changed.emit()
		return ""


func add_line(contents):
	string_contents.append(str(contents))
	string_contents_changed.emit()

func get_num_lines() -> int:
	return _child_labels.size()


func clear():
	for n in get_children():
		remove_child(n)
		n.queue_free()
	string_contents = []
	_child_labels = []
	labels_changed.emit()


func _add_label_child(contents: String):
	var l = _new_label(contents)
	add_child(l)
	_child_labels.append(l)

func _on_string_contents_changed():
	_child_labels = []
	for s in string_contents:
		_child_labels.append(_new_label())


func _new_label(text = "") -> Label:
	var label = Label.new()
	label.text = str(text)
	label.horizontal_alignment = child_h_alignmnent
	label.vertical_alignment = child_v_alignment
	return label
