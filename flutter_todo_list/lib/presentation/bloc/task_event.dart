import 'package:flutter_todo_list/domain/entities/task.dart';

abstract class TaskEvent {
  const TaskEvent();
}

class GetTasksEvent extends TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final TodoTask task;

  const AddTaskEvent(this.task);
}

class UpdateTaskEvent extends TaskEvent {
  final TodoTask task;

  const UpdateTaskEvent(this.task);
}

class DeleteTaskEvent extends TaskEvent {
  final String taskId;

  const DeleteTaskEvent(this.taskId);
}
