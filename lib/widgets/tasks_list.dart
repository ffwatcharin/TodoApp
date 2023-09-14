import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/widgets/task_tile.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    super.key,
    required this.tasksList,
  });

  final List<Task> tasksList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          var task = tasksList[index];
          return TaskTile(task: task);
        },
        itemCount: tasksList.length,
      ),
    );
  }
}
