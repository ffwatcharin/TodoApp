import 'package:flutter/material.dart';
import 'package:todo_app/blocs/bloc_export.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/screens/add_task_screen.dart';

import 'package:todo_app/widgets/tasks_list.dart';

// ignore: must_be_immutable
class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});
  static const id = 'tasks_screen';

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  TextEditingController titleController = TextEditingController();

  void _addTask(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: const AddTaskScreen(),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> tasksList = state.allTask;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.amberAccent,
            actions: [
              IconButton(
                onPressed: () => _addTask(context),
                icon: const Icon(Icons.add),
              ),
            ],
            title: const Text(
              'Todo App 📃',
              style: TextStyle(
                  fontFamily: 'Prompt',
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
          ),
          backgroundColor: Colors.yellow,
          body: Container(
            margin: const EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [TaskList(tasksList: tasksList)],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _addTask(context),
            tooltip: 'Add Task',
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
