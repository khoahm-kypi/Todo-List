import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_list/presentation/bloc/task_event.dart';
import '../../domain/entities/task.dart';
import '../bloc/task_bloc.dart';
import 'edit_task_form.dart';

class TaskListItem extends StatelessWidget {
  final TodoTask task;

  const TaskListItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        task.title,
        style: TextStyle(
          decoration:
              task.isDone ? TextDecoration.lineThrough : TextDecoration.none,
          color: task.isDone ? Colors.grey : Colors.black,
        ),
      ),
      leading: Checkbox(
        value: task.isDone,
        onChanged: (bool? value) {
          context.read<TaskBloc>().add(UpdateTaskEvent(
                task.copyWith(isDone: value ?? false),
              ));
        },
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (_) => EditTaskForm(task: task),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              context.read<TaskBloc>().add(DeleteTaskEvent(task.id));
            },
          ),
        ],
      ),
    );
  }
}
