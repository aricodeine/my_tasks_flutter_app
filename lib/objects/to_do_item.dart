import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'to_do_item.g.dart';

@HiveType(typeId: 0)
class ToDoItem {
  @HiveField(0)
  final String itemName;
  @HiveField(1)
  bool isCompleted;

  ToDoItem({required this.itemName, required this.isCompleted});

  void changeIsCompletedValue() {
    isCompleted = !isCompleted;
  }
}
