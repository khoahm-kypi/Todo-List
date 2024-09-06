import 'package:dartz/dartz.dart';
import 'package:flutter_todo_list/core/use_case.dart';
import '../entities/task.dart';

abstract class TaskRepository {
  Future<Either<Failure, List<TodoTask>>> getTasks();
  Future<Either<Failure, TodoTask>> addTask(TodoTask task);
  Future<Either<Failure, TodoTask>> updateTask(TodoTask task);
  Future<Either<Failure, void>> deleteTask(String id);
}
