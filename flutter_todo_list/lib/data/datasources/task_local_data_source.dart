import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task_model.dart';

abstract class TaskLocalDataSource {
  Future<List<TaskModel>> getTasks();
  Future<void> cacheTasks(List<TaskModel> tasks);
}

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  final SharedPreferences sharedPreferences;

  TaskLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<TaskModel>> getTasks() {
    final jsonString = sharedPreferences.getString('CACHED_TASKS');
    if (jsonString != null) {
      return Future.value(json
          .decode(jsonString)
          .map<TaskModel>((json) => TaskModel.fromJson(json))
          .toList());
    } else {
      return Future.value([]);
    }
  }

  @override
  Future<void> cacheTasks(List<TaskModel> tasks) {
    return sharedPreferences.setString(
      'CACHED_TASKS',
      json.encode(tasks.map((task) => task.toJson()).toList()),
    );
  }
}
