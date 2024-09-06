import 'package:flutter/material.dart';
import '../../domain/entities/task.dart';
import 'task_list_item.dart';

class TaskList extends StatelessWidget {
  final List<TodoTask> tasks;

  const TaskList({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return TaskListItem(task: tasks[index]);
      },
    );
  }
}
