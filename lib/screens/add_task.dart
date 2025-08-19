// Import necessary packages for UI, database, widgets, and utilities.
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/widget/task_type_item_list.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:notes/data/task.dart';
import 'package:notes/utility/utility.dart';

// A stateful widget for adding a new task.
class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  // Focus nodes to manage the focus of text fields.
  FocusNode myFocusNode1 = FocusNode();
  FocusNode myFocusNode2 = FocusNode();

  // Controllers for the text fields to manage their content.
  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerSubTitle = TextEditingController();
  // The Hive box for storing tasks.
  final Box<Task> box = Hive.box<Task>('taskBox');

  // The index of the selected task type.
  int selectedTaskTypeItem = 0;

  @override
  void initState() {
    super.initState();
    // Add listeners to the focus nodes to rebuild the UI when focus changes.
    myFocusNode1.addListener(() {
      setState(() {});
    });
    myFocusNode2.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // Dispose of the focus nodes to free up resources.
    myFocusNode1.dispose();
    myFocusNode2.dispose();
    super.dispose();
  }

  // The selected time for the task.
  Time? _time = Time(hour: 22, minute: 30);
  // The selected date and time for the task.
  DateTime? _dateTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Prevents the UI from resizing when the keyboard appears.
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 50),
              // Text field for the task title.
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 44),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    controller: controllerTitle,
                    focusNode: myFocusNode1,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    cursorColor: const Color(0xffF35383),
                    decoration: InputDecoration(
                      labelText: 'عنوان تسک',
                      labelStyle: TextStyle(
                        color: myFocusNode1.hasFocus
                            ? const Color(0xff18daa3)
                            : const Color(0xffC5C5C5),
                        fontSize: 20,
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        borderSide: BorderSide(
                          width: 3,
                          color: Color(0xffC5C5C5),
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                        borderSide: BorderSide(
                          width: 3,
                          color: Color(0xff18daa3),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              // Text field for the task subtitle/description.
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 44),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    keyboardType: TextInputType.name,
                    controller: controllerSubTitle,
                    maxLines: 2,
                    focusNode: myFocusNode2,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    cursorColor: const Color(0xffF35383),
                    decoration: InputDecoration(
                      labelText: 'توضیحات',
                      labelStyle: TextStyle(
                        color: myFocusNode2.hasFocus
                            ? const Color(0xff18daa3)
                            : const Color(0xffC5C5C5),
                        fontSize: 20,
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        borderSide: BorderSide(
                          width: 3,
                          color: Color(0xffC5C5C5),
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                        borderSide: BorderSide(
                          width: 3,
                          color: Color(0xff18daa3),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              // Button to open the time picker.
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    showPicker(
                      context: context,
                      value: _time!,
                      onChange: (Time time) {
                        _time = time;
                      },
                      minuteInterval: TimePickerInterval.FIVE,
                      onChangeDateTime: (DateTime dateTime) {
                        _dateTime = dateTime;
                      },
                    ),
                  );
                },
                child: const Text(
                  "زمان رو انتخاب کن",
                  style: TextStyle(
                    color: Color(
                      0xff18daa3,
                    ),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Horizontal list of task types.
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: getTaskTypeList().length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedTaskTypeItem = index;
                        });
                      },
                      child: TaskTypeItemList(
                        taskType: getTaskTypeList()[index],
                        index: index,
                        selectdItemList: selectedTaskTypeItem,
                      ),
                    );
                  },
                ),
              ),
              const Spacer(),
              // Button to add the task.
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff18daa3),
                  minimumSize: const Size(200, 48),
                ),
                onPressed: () {
                  String taskTitle = controllerTitle.text;
                  String tastSubTitle = controllerSubTitle.text;
                  addTask(taskTitle, tastSubTitle);
                  Navigator.pop(context);
                },
                child: const Text(
                  'اضافه کردن تسک',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  // Method to add a new task to the Hive box.
  addTask(String taskTitle, String tastSubTitle) {
    Task task = Task(
        title: taskTitle,
        subTitle: tastSubTitle,
        time: _dateTime,
        taskType: getTaskTypeList()[selectedTaskTypeItem]);
    box.add(task);
  }
}
