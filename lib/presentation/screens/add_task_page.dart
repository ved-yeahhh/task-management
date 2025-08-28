import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_mgmt/bloc/task/task_bloc.dart';
import 'package:task_mgmt/bloc/task/task_event.dart';
import 'package:task_mgmt/data/models/task_model.dart';
import 'package:task_mgmt/presentation/widgets/textformfield.dart';
import 'package:intl/intl.dart' as intl;

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _titleController = TextEditingController();
    final TextEditingController _descriptionController =
        TextEditingController();
    final TextEditingController _dateController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.navigate_before),
        ),
        title: Text('ADD TASK'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(21.0),
        child: Column(
          children: [
            Textformfield(label: 'Task Title', controller: _titleController),
            SizedBox(height: 8.0),
            Textformfield(
              label: 'Task Description',
              controller: _descriptionController,
              maxLines: 4,
            ),
            SizedBox(height: 8.0),
            Textformfield(
              label: 'Date',
              controller: _dateController,
              isDate: true,
            ),
            SizedBox(height: 20.0),
            MaterialButton(
              minWidth: double.infinity,
              height: 50.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              color: Colors.black,
              onPressed: () {
                final task = Task(
                  id: DateTime.now().toString(),
                  title: _titleController.text,
                  description: _descriptionController.text,
                  date: intl.DateFormat(
                    'dd-MM-yyyy',
                  ).parse(_dateController.text),
                );
                context.read<TaskBloc>().add(AddTask(task));
                Navigator.pop(context);
              },
              textColor: Colors.white,
              child: Text('SAVE TASK'),
            ),
          ],
        ),
      ),
    );
  }
}
