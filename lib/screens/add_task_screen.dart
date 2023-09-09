import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:todo_app/blocs/bloc/tasks_bloc.dart';
import 'package:todo_app/blocs/bloc_export.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/services/guid_den.dart';

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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            alwaysUse24HourFormat: true, // ใช้รูปแบบ 24 ชั่วโมง
          ),
          child: child!,
        );
      },
    );
    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

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
                final DateTime selectedDateTime = DateTime(
                  selectedDate.year,
                  selectedDate.month,
                  selectedDate.day,
                  selectedTime.hour,
                  selectedTime.minute,
                );
                var task = Task(
                  title: titleController.text,
                  id: GUIDGen.generate(),
                  dateTime: selectedDateTime,
                );
                context.read<TasksBloc>().add(AddTask(task: task));

                Navigator.pop(context);
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
            ElevatedButton(
              onPressed: () => _selectTime(context), // เรียกใช้งาน _selectTime
              child: const Text(
                'Select Time',
                style: TextStyle(fontFamily: 'Prompt'),
              ),
            ),
            ElevatedButton(
              onPressed: () => _selectDate(context), // เรียกใช้งาน _selectDate
              child: const Text(
                'Select Date',
                style: TextStyle(fontFamily: 'Prompt'),
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
