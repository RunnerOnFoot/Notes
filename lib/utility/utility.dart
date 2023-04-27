import '../data/task_type.dart';
import '../data/type_enum.dart';

List<TaskType> getTaskTypeList() {
  List<TaskType> list = <TaskType>[
    TaskType(
      image: 'assets/images/meditate.png',
      title: 'تمرکز',
      enumType: TaskTypeEnum.foucs,
    ),
    TaskType(
      image: 'assets/images/social_frends.png',
      title: 'میتینگ',
      enumType: TaskTypeEnum.date,
    ),
    TaskType(
      image: 'assets/images/hard_working.png',
      title: 'کار زیاد',
      enumType: TaskTypeEnum.working,
    ),
    TaskType(
      image: 'assets/images/banking.png',
      title: 'کار اداری',
      enumType: TaskTypeEnum.official,
    ),
    TaskType(
      image: 'assets/images/workout.png',
      title: 'ورزش',
      enumType: TaskTypeEnum.gym,
    ),
    TaskType(
      image: 'assets/images/work_meeting.png',
      title: 'میتینگ کاری',
      enumType: TaskTypeEnum.businessDate,
    ),
  ];

  return list;
}
