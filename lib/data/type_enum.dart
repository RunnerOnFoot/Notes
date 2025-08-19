// Import necessary packages.
import 'package:hive_flutter/hive_flutter.dart';

// This line indicates that 'type_enum.g.dart' is a generated file that is part of this library.
part 'type_enum.g.dart';

// Annotate the enum with @HiveType to generate a TypeAdapter. 'typeId' must be unique.
@HiveType(typeId: 5)
// The TaskTypeEnum defines a set of predefined task types.
enum TaskTypeEnum {
  // Annotate each enum value with @HiveField and a unique index.
  @HiveField(0)
  working, // Represents a working task.

  @HiveField(1)
  date, // Represents a date-related task.

  @HiveField(2)
  foucs, // Represents a focus-related task.

  @HiveField(3)
  official, // Represents an official task.

  @HiveField(4)
  gym, // Represents a gym-related task.

  @HiveField(5)
  businessDate, // Represents a business date task.
}
