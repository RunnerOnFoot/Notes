import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'data/task.dart';
import 'data/task_type.dart';
import 'data/type_enum.dart';
import 'screens/home_page.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(TaskTypeAdapter());
  Hive.registerAdapter(TaskTypeEnumAdapter());
  if (!Hive.isBoxOpen('taskBox')) {
    await Hive.openBox<Task>('taskBox');
  }
  runApp(
    const Application(),
  );
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'SM'),
      home: const HomePage(),
    );
  }
}
