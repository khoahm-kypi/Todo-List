import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_list/core/use_case.dart';
import '../../domain/usecases/get_tasks.dart';
import '../../domain/usecases/add_task.dart';
import '../../domain/usecases/update_task.dart';
import '../../domain/usecases/delete_task.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTasks getTasks;
  final AddTask addTask;
  final UpdateTask updateTask;
  final DeleteTask deleteTask;

  TaskBloc({
    required this.getTasks,
    required this.addTask,
    required this.updateTask,
    required this.deleteTask,
  }) : super(TaskInitial()) {
    on<GetTasksEvent>(_onGetTasks);
    on<AddTaskEvent>(_onAddTask);
    on<UpdateTaskEvent>(_onUpdateTask);
    on<DeleteTaskEvent>(_onDeleteTask);
  }

  void _onGetTasks(GetTasksEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    final failureOrTasks = await getTasks(NoParams());
    emit(failureOrTasks.fold(
      (failure) => TaskError(message: _mapFailureToMessage(failure)),
      (tasks) => TaskLoaded(tasks: tasks),
    ));
  }

  void _onAddTask(AddTaskEvent event, Emitter<TaskState> emit) async {
    final currentState = state;
    if (currentState is TaskLoaded) {
      emit(TaskLoading());
      final failureOrTask = await addTask(AddTaskParams(task: event.task));
      failureOrTask.fold(
        (failure) => emit(TaskError(message: _mapFailureToMessage(failure))),
        (newTask) => emit(
            TaskLoaded(tasks: List.from(currentState.tasks)..add(newTask))),
      );
    }
  }

  void _onUpdateTask(UpdateTaskEvent event, Emitter<TaskState> emit) async {
    final currentState = state;
    if (currentState is TaskLoaded) {
      emit(TaskLoading());
      final failureOrTask =
          await updateTask(UpdateTaskParams(task: event.task));
      failureOrTask.fold(
        (failure) => emit(TaskError(message: _mapFailureToMessage(failure))),
        (updatedTask) {
          final updatedTasks = currentState.tasks
              .map((task) => task.id == updatedTask.id ? updatedTask : task)
              .toList();
          emit(TaskLoaded(tasks: updatedTasks));
        },
      );
    }
  }

  void _onDeleteTask(DeleteTaskEvent event, Emitter<TaskState> emit) async {
    final currentState = state;
    if (currentState is TaskLoaded) {
      emit(TaskLoading());
      final failureOrVoid =
          await deleteTask(DeleteTaskParams(id: event.taskId));
      failureOrVoid.fold(
        (failure) => emit(TaskError(message: _mapFailureToMessage(failure))),
        (_) {
          final updatedTasks = currentState.tasks
              .where((task) => task.id != event.taskId)
              .toList();
          emit(TaskLoaded(tasks: updatedTasks));
        },
      );
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Lỗi máy chủ';
      case CacheFailure:
        return 'Lỗi bộ nhớ đệm';
      default:
        return 'Lỗi không xác định';
    }
  }
}
