import 'package:dartz/dartz.dart';
import 'package:flutter_todo_list/core/use_case.dart';
import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/task_local_data_source.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDataSource localDataSource;

  TaskRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<TodoTask>>> getTasks() async {
    try {
      final localTasks = await localDataSource.getTasks();
      return Right(localTasks);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, TodoTask>> addTask(TodoTask task) async {
    try {
      final tasks = await localDataSource.getTasks();
      final newTask = TaskModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: task.title,
      );
      tasks.add(newTask);
      await localDataSource.cacheTasks(tasks);
      return Right(newTask);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteTask(String id) async {
    try {
      final tasks = await localDataSource.getTasks();
      tasks.removeWhere((task) => task.id == id);
      await localDataSource.cacheTasks(tasks);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, TodoTask>> updateTask(TodoTask task) async {
    try {
      final tasks = await localDataSource.getTasks();
      final index = tasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        tasks[index] = TaskModel.fromTask(task);
        await localDataSource.cacheTasks(tasks);
        return Right(task);
      }
      return Left(CacheFailure());
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
