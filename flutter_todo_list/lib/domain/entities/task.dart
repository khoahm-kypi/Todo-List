import 'package:equatable/equatable.dart';

class TodoTask extends Equatable {
  final String id;
  final String title;
  final bool isDone;

  const TodoTask({
    required this.id,
    required this.title,
    this.isDone = false,
  });

  @override
  List<Object?> get props => [id, title, isDone];

  TodoTask copyWith({
    String? id,
    String? title,
    bool? isDone,
  }) {
    return TodoTask(
      id: id ?? this.id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
    );
  }
}
