import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:todoey_flutter/models/task.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:collection';

class TaskData extends ChangeNotifier{
  final List<Task> _task = [];

  UnmodifiableListView<Task> get task{
    return UnmodifiableListView(_task);
  }

  _write() async {
    List<Map<String,dynamic>> archiveTask = [];
    for(var item in _task){
      print(item);
      archiveTask.add({'name': item.name, 'isDone' : item.isDone});
    }
    print(archiveTask);
    String text = jsonEncode(archiveTask);
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/my_file.json');
    await file.writeAsString(text);
  }

  Future<String> _read() async {
    String text = "";
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/my_file.json');
      text = await file.readAsString();
    } catch (e) {
      print("Couldn't read file : $e");
    }
    return text;
  }

  void setLastData() async{
    final String response = await _read();
    final lastData = await json.decode(response);
    print(lastData);

    _task.clear();
    print("clear");
    for (var item in lastData){
      print(item);
      final newTask = Task(name: item['name'].toString(), isDone: item['isDone']);
      _task.add(newTask);
      print("${_task.last.name} ${_task.last.isDone}");
    }
    notifyListeners();
    getAll();
  }

  void getAll(){
    for (var item in _task){
      print("${item.name} ${item.isDone}");
    }
  }

  int get taskCount{
    return _task.length;
  }

  void toggleDone(int index){
    print("name:${_task[index].name} , isDone:${_task[index].isDone}");
    _task[index].isDone = !_task[index].isDone;
    _write();
    notifyListeners();
    print("name:${_task[index].name} , isDone:${_task[index].isDone}");
  }

  void addTask(String newTaskTitle){
    final newTask = Task(name: newTaskTitle, isDone: false);
    _task.add(newTask);
    _write();
    getAll();
    notifyListeners();
  }

  void deleteTask(Task task){
    _task.remove(task);
    _write();
    notifyListeners();
  }
}
