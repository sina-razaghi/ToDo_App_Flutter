// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class TaskTitle extends StatelessWidget {
  final bool isChecked;
  final String taskTitle;
  final Function(bool?) checkBoxCallBack;
  final Function() holdToDeleteTask;

  TaskTitle({
    required this.isChecked,
    required this.taskTitle,
    required this.checkBoxCallBack,
    required this.holdToDeleteTask
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: holdToDeleteTask,
      title: Text(
        taskTitle,
        style: TextStyle(
          decoration: isChecked ? TextDecoration.lineThrough : null
        ),
      ),
      trailing: Checkbox(
        value: isChecked,
        activeColor: Colors.lightBlueAccent,
        onChanged: checkBoxCallBack,
      ),
    );
  }
}



