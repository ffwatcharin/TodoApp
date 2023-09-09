import 'package:flutter/material.dart';
import 'package:todo_app/blocs/bloc_export.dart';
import 'package:todo_app/models/task.dart';
import 'package:intl/intl.dart';

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
          return ListTile(
            title: Text(
              '- ${task.title}',
              style: const TextStyle(
                  fontFamily: 'Prompt',
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
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
                            DateFormat(': EEEE, dd-MMMM-y')
                                .format(task.dateTime!),
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
            onLongPress: () =>
                context.read<TasksBloc>().add(DeleteTask(task: task)),
          );
        },
        itemCount: tasksList.length,
      ),
    );
  }
}
