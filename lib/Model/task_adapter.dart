import 'package:hive_flutter/hive_flutter.dart';
import 'package:salakhana_project/Model/task.dart';

class TaskAdapter extends TypeAdapter<Task> {
  @override
  Task read(BinaryReader reader) {
    // implement read

    final title = reader.readString();
    final description = reader.read() as String?;
    final deadline = reader.read() as String?;
    final isDone = reader.readBool();
    //some thing strange here may delete
    //final createdAt = reader.readDateTime();

    return Task(
      title: title,
      description: description,
      deadline: deadline,
      isDone: isDone,
      //createdAt: createdAt,
    );

  }

  @override
  // implement typeId
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, Task obj) {
    //implement write
    writer.writeString(obj.title);
    writer.write(obj.description);
    writer.write(obj.deadline);
    writer.writeBool(obj.isDone);
    //writer.writeDateTime(obj.createdAt);

  }

}

/*extension on BinaryWriter {
  void writeDateTime(DateTime createdAt) {}
}

extension on BinaryReader {
  readDateTime() {}
}*/