import 'package:flutter/material.dart';

// ignore: unnecessary_import
import 'package:todo_app/blocs/bloc/tasks_bloc.dart';
import 'package:todo_app/blocs/bloc_export.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/services/guid_den.dart';
import 'package:todo_app/services/notification_service.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController titleController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime scheduleTime = DateTime.now();
  NotificationService notificationService = NotificationService();

  Future<void> _selectDateAndTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      // ignore: use_build_context_synchronously
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        },
      );
      if (pickedTime != null) {
        final DateTime selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        setState(() {
          selectedDate = selectedDateTime;
          selectedTime = pickedTime;
          scheduleTime = selectedDateTime;
        });
      }
    }
  }

// Future<void> _selectDate(BuildContext context) async {}

  // Future<void> _selectTime(BuildContext context) async {
  //   final TimeOfDay? pickedTime = await showTimePicker(
  //     context: context,
  //     initialTime: selectedTime,
  //     builder: (BuildContext context, Widget? child) {
  //       return MediaQuery(
  //         data: MediaQuery.of(context).copyWith(
  //           alwaysUse24HourFormat: true,
  //         ),
  //         child: child!,
  //       );
  //     },
  //   );
  //   if (pickedTime != null && pickedTime != selectedTime) {
  //     setState(() {
  //       selectedTime = pickedTime;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(children: [
        const Text(
          'Add Task',
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'Prompt',
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          autofocus: true,
          controller: titleController,
          decoration: const InputDecoration(
            label: Text(
              'ใส่อะไรซักอย่างหน่อย...',
              style: TextStyle(
                fontFamily: 'Prompt',
                color: Colors.grey,
              ),
            ),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: () async {
                // final DateTime selectedDateTime = DateTime(
                //   selectedDate.year,
                //   selectedDate.month,
                //   selectedDate.day,
                //   selectedTime.hour,
                //   selectedTime.minute,
                // );

                if (scheduleTime.isAfter(DateTime.now())) {
                  NotificationService().scheduleNotification(
                    title: titleController.text,
                    body: '$scheduleTime',
                    scheduleNotificationDatetime: scheduleTime,
                  );

                  var task = Task(
                    title: titleController.text,
                    id: GUIDGen.generate(),
                    dateTime: selectedDate,
                  );
                  context.read<TasksBloc>().add(AddTask(task: task));

                  Navigator.pop(context);
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Date/Time'),
                          content: const Text(
                              'Please select a date and time again.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      });
                }
              },
              icon: const Icon(
                Icons.add,
                color: Colors.green,
              ),
              label: const Text(
                'ADD',
                style: TextStyle(fontFamily: 'Prompt', color: Colors.green),
              ),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     _selectTime(context);
            //   }, // เรียกใช้งาน _selectTime
            //   child: const Text(
            //     'Select Time',
            //     style: TextStyle(fontFamily: 'Prompt'),
            //   ),
            // ),
            // ElevatedButton(
            //   onPressed: () => _selectDate(context), // เรียกใช้งาน _selectDate
            //   child: const Text(
            //     'Select Date',
            //     style: TextStyle(fontFamily: 'Prompt'),
            //   ),
            // ),
            ElevatedButton(
              onPressed: () => _selectDateAndTime(context),
              child: const Text(
                'Select Date & Time',
                style: TextStyle(
                  fontFamily: 'Prompt',
                  color: Colors.black,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'CANCEL',
                style: TextStyle(fontFamily: 'Prompt', color: Colors.red),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
