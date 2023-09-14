import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/blocs/bloc_export.dart';
import 'package:todo_app/models/task.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Expanded(
            child: Tooltip(
              message: 'Title : ${task.title}',
              decoration: BoxDecoration(
                color: Colors.brown,
                borderRadius: BorderRadius.circular(20),
              ),
              textStyle:
                  const TextStyle(fontFamily: 'Prompt', color: Colors.white),
              child: Text(
                task.title,
                style: TextStyle(
                    decoration: task.isDone!
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    decorationColor: Colors.red,
                    decorationThickness: 3,
                    fontFamily: 'Prompt',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const Spacer(),
          PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'delete') {
                  context.read<TasksBloc>().add(DeleteTask(task: task));
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'delete',
                      child: Text('Delete'),
                    )
                  ])
        ],
      ),
      subtitle: task.dateTime != null
          ? Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      color: Colors.black,
                      size: 16,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      DateFormat(': EEEE, dd-MMMM-y').format(task.dateTime!),
                      style: const TextStyle(
                          fontFamily: 'Prompt',
                          fontWeight: FontWeight.w100,
                          color: Color.fromARGB(255, 119, 119, 119)),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      color: Colors.black,
                      size: 16,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      DateFormat(': HH:mm a').format(task.dateTime!),
                      style: const TextStyle(
                          fontFamily: 'Prompt',
                          fontWeight: FontWeight.w100,
                          color: Color.fromARGB(255, 119, 119, 119)),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
              ],
            )
          : const Text(
              'null',
              style: TextStyle(fontFamily: 'Prompt'),
            ),
      trailing: Checkbox(
        value: task.isDone,
        onChanged: (value) {
          context.read<TasksBloc>().add(UpdateTask(task: task));
        },
      ),
      // onLongPress: () => context.read<TasksBloc>().add(DeleteTask(task: task)),
    );
  }
}
