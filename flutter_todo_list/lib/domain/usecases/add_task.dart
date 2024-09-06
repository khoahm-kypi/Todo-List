import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';
import '../../core/use_case.dart';

class AddTask implements UseCase<TodoTask, AddTaskParams> {
  final TaskRepository repository;

  AddTask(this.repository);

  @override
  Future<Either<Failure, TodoTask>> call(AddTaskParams params) async {
    return await repository.addTask(params.task);
  }
}

class AddTaskParams extends Equatable {
  final TodoTask task;

  const AddTaskParams({required this.task});

  @override
  List<Object> get props => [task];
}
