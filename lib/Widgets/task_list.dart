// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/Widgets/task_title.dart';
import '../models/task_data.dart';

class TasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return TaskTitle(
              taskTitle: taskData.task[index].name,
              isChecked: taskData.task[index].isDone,
              checkBoxCallBack: (bool? value) {
                // taskData.task[index].toggleDone();
                taskData.toggleDone(index);
              },
              holdToDeleteTask: (){
                taskData.deleteTask(taskData.task[index]);
              },
            );
          },
          itemCount: taskData.taskCount,
        );
      },
    );
  }
}
