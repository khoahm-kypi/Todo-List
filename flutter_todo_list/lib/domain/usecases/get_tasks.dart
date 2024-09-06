import 'package:dartz/dartz.dart' as dartz;
import '../entities/task.dart';
import '../repositories/task_repository.dart';
import '../../core/use_case.dart';

class GetTasks implements UseCase<List<TodoTask>, NoParams> {
  final TaskRepository repository;

  GetTasks(this.repository);

  @override
  Future<dartz.Either<Failure, List<TodoTask>>> call(NoParams params) async {
    return await repository.getTasks();
  }
}
