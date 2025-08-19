// Import necessary packages for Flutter and Hive database.
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

// Import data models and screens used in the application.
import 'data/task.dart';
import 'data/task_type.dart';
import 'data/type_enum.dart';
import 'screens/home_page.dart';

// The main entry point of the application.
void main() async {
  // Initialize Hive for Flutter.
  await Hive.initFlutter();
  // Register Hive adapters for custom data types.
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(TaskTypeAdapter());
  Hive.registerAdapter(TaskTypeEnumAdapter());
  // Open the 'taskBox' if it's not already open. This box will store Task objects.
  if (!Hive.isBoxOpen('taskBox')) {
    await Hive.openBox<Task>('taskBox');
  }
  // Run the main application widget.
  runApp(
    const Application(),
  );
}

// The root widget of the application.
class Application extends StatelessWidget {
  // Constructor for the Application widget.
  const Application({super.key});

  // This method builds the widget tree for the application.
  @override
  Widget build(BuildContext context) {
    // MaterialApp is the root of your app.
    return MaterialApp(
      // Hides the debug banner in the top right corner.
      debugShowCheckedModeBanner: false,
      // Sets the default font for the application.
      theme: ThemeData(fontFamily: 'SM'),
      // Sets the home page of the application.
      home: const HomePage(),
    );
  }
}
