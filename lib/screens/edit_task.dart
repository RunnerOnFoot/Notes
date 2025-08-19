import 'package:day_night_time_picker/day_night_time_picker.dart';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/widget/task_type_item_list.dart';

import 'package:notes/data/task.dart';
import '../utility/utility.dart';

class EditTask extends StatefulWidget {
  EditTask({super.key, required this.task});

  Task task;

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  FocusNode myFocusNode1 = FocusNode();
  FocusNode myFocusNode2 = FocusNode();

  late TextEditingController controllerTitle =
      TextEditingController(text: widget.task.title);
  late TextEditingController controllerSubTitle =
      TextEditingController(text: widget.task.subTitle);
  final Box<Task> box = Hive.box<Task>('taskBox');
  @override
  void initState() {
    myFocusNode1.addListener(() {
      setState(() {});
    });
    myFocusNode2.addListener(() {
      setState(() {});
    });

    selectedTaskTypeItem = getTaskTypeList().indexWhere(
      (element) {
        return element.enumType == widget.task.taskType.enumType;
      },
    );

    // switch (widget.task.taskType.enumType) {
    //   case TaskTypeEnum.working:
    //     selectedTaskTypeItem = 0;
    //     break;
    //   case TaskTypeEnum.date:
    //     selectedTaskTypeItem = 1;
    //     break;
    //   case TaskTypeEnum.foucs:
    //     selectedTaskTypeItem = 2;
    //     break;
    //   case TaskTypeEnum.official:
    //     selectedTaskTypeItem = 3;
    //     break;
    //   case TaskTypeEnum.gym:
    //     selectedTaskTypeItem = 4;
    //     break;
    //   case TaskTypeEnum.businessDate:
    //     selectedTaskTypeItem = 5;
    //     break;
    //   default:
    // }

    super.initState();
  }

  @override
  void dispose() {
    myFocusNode1.dispose();
    myFocusNode2.dispose();

    super.dispose();
  }

  Time _time = Time(hour: 22, minute: 30);

  DateTime? _dateTime;

  int selectedTaskTypeItem = 0;

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
              const SizedBox(height: 100),
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
                  editTask(
                    taskTitle,
                    tastSubTitle,
                    _dateTime!,
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

  editTask(
    String taskTitle,
    String tastSubTitle,
    DateTime? dateTime,
  ) {
    widget.task.title = taskTitle;
    widget.task.subTitle = tastSubTitle;
    widget.task.time = dateTime;
    widget.task.taskType = getTaskTypeList()[selectedTaskTypeItem];
    widget.task.save();
  }
}
