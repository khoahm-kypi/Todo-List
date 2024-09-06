import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';
import '../../core/use_case.dart';

class UpdateTask implements UseCase<TodoTask, UpdateTaskParams> {
  final TaskRepository repository;

  UpdateTask(this.repository);

  @override
  Future<Either<Failure, TodoTask>> call(UpdateTaskParams params) async {
    return await repository.updateTask(params.task);
  }
}

class UpdateTaskParams extends Equatable {
  final TodoTask task;

  const UpdateTaskParams({required this.task});

  @override
  List<Object> get props => [task];
}
