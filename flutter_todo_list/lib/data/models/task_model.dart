import '../../domain/entities/task.dart';

class TaskModel extends TodoTask {
  const TaskModel({
    required super.id,
    required super.title,
    super.isDone,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      isDone: json['isDone'],
    );
  }

  factory TaskModel.fromTask(TodoTask task) {
    return TaskModel(
      id: task.id,
      title: task.title,
      isDone: task.isDone,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isDone': isDone,
    };
  }
}
