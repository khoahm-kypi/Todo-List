import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_list/presentation/bloc/task_event.dart';
import '../../domain/entities/task.dart';
import '../bloc/task_bloc.dart';

class EditTaskForm extends StatefulWidget {
  final TodoTask task;

  const EditTaskForm({Key? key, required this.task}) : super(key: key);

  @override
  _EditTaskFormState createState() => _EditTaskFormState();
}

class _EditTaskFormState extends State<EditTaskForm> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.task.title);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(labelText: 'Edit Task'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                final updatedTask = widget.task.copyWith(
                  title: _controller.text,
                );
                context.read<TaskBloc>().add(UpdateTaskEvent(updatedTask));
                Navigator.pop(context);
              }
            },
            child: const Text('Update Task'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
