import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_list/presentation/bloc/task_bloc.dart';
import 'package:flutter_todo_list/presentation/bloc/task_event.dart';
import 'package:flutter_todo_list/presentation/pages/home_page.dart';
import 'package:flutter_todo_list/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<TaskBloc>()..add(GetTasksEvent()),
      child: MaterialApp(
        title: 'Flutter Todo List',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}
