import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/widget/task_type_item_list.dart';

import 'package:day_night_time_picker/day_night_time_picker.dart';

import '../data/task.dart';
import '../utility/utility.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  FocusNode myFocusNode1 = FocusNode();
  FocusNode myFocusNode2 = FocusNode();

  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerSubTitle = TextEditingController();
  final Box<Task> box = Hive.box<Task>('taskBox');

  int selectedTaskTypeItem = 0;
  @override
  void initState() {
    myFocusNode1.addListener(() {
      setState(() {});
    });
    myFocusNode2.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    myFocusNode1.dispose();
    myFocusNode2.dispose();

    super.dispose();
  }

  Time? _time = Time(hour: 22, minute: 30);
  DateTime? _dateTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 50),
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
                      // Optional onChange to receive value as DateTime
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

  addTask(String taskTitle, String tastSubTitle) {
    Task task = Task(
        title: taskTitle,
        subTitle: tastSubTitle,
        time: _dateTime,
        taskType: getTaskTypeList()[selectedTaskTypeItem]);
    box.add(task);
  }
}
