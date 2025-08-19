// Import necessary packages for UI, database, widgets, and utilities.
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/widget/task_type_item_list.dart';
import 'package:notes/data/task.dart';
import '../utility/utility.dart';

// A stateful widget for editing an existing task.
class EditTask extends StatefulWidget {
  EditTask({super.key, required this.task});

  // The task to be edited.
  final Task task;

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  // Focus nodes to manage the focus of text fields.
  FocusNode myFocusNode1 = FocusNode();
  FocusNode myFocusNode2 = FocusNode();

  // Controllers for the text fields, initialized with the task's current data.
  late TextEditingController controllerTitle =
      TextEditingController(text: widget.task.title);
  late TextEditingController controllerSubTitle =
      TextEditingController(text: widget.task.subTitle);
  // The Hive box for storing tasks.
  final Box<Task> box = Hive.box<Task>('taskBox');

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

    // Set the selected task type based on the current task's type.
    selectedTaskTypeItem = getTaskTypeList().indexWhere(
      (element) {
        return element.enumType == widget.task.taskType.enumType;
      },
    );
  }

  @override
  void dispose() {
    // Dispose of the focus nodes to free up resources.
    myFocusNode1.dispose();
    myFocusNode2.dispose();
    super.dispose();
  }

  // The selected time for the task.
  Time _time = Time(hour: 22, minute: 30);
  // The selected date and time for the task.
  DateTime? _dateTime;
  // The index of the selected task type.
  int selectedTaskTypeItem = 0;

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
              const SizedBox(height: 100),
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
                      labelText: 'توضیحات تسک',
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
              // Button to open the time picker.
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    showPicker(
                      context: context,
                      value: _time,
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
              // Button to save the edited task.
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff18daa3),
                  minimumSize: const Size(200, 48),
                ),
                onPressed: () {
                  String taskTitle = controllerTitle.text;
                  String tastSubTitle = controllerSubTitle.text;
                  editTask(
                    taskTitle,
                    tastSubTitle,
                    _dateTime,
                  );
                  Navigator.pop(context);
                },
                child: const Text(
                  'ویررایش کردن تسک',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to save the edited task.
  editTask(
    String taskTitle,
    String tastSubTitle,
    DateTime? dateTime,
  ) {
    widget.task.title = taskTitle;
    widget.task.subTitle = tastSubTitle;
    widget.task.time = dateTime ?? widget.task.time; // Keep old time if new one is null
    widget.task.taskType = getTaskTypeList()[selectedTaskTypeItem];
    widget.task.save(); // Save the changes to the Hive box.
  }
}
