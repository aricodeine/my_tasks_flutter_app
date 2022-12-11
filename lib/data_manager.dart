import 'package:hive_flutter/hive_flutter.dart';
import 'package:mytasks/objects/to_do_item.dart';

class DataManager {
  static var tasksBox = Hive.box('tasksbox');

  static void reorderListView(int oldIndex, int newIndex) {
    ToDoItem tempItem;
    if (oldIndex < newIndex) {
      newIndex--;
      for (int i = oldIndex; i < newIndex; i++) {
        tempItem = tasksBox.getAt(i + 1);
        ToDoItem currentItem = tasksBox.getAt(i);
        tasksBox.putAt(i + 1, currentItem);
        tasksBox.putAt(i, tempItem);
      }
    } else {
      for (int i = oldIndex; i > newIndex; i--) {
        tempItem = tasksBox.getAt(i - 1);
        ToDoItem currentItem = tasksBox.getAt(i);
        tasksBox.putAt(i - 1, currentItem);
        tasksBox.putAt(i, tempItem);
      }
    }
  }

  static void addToTasksData(String text) {
    tasksBox.add(ToDoItem(itemName: text, isCompleted: false));
  }

  static void removeTaskFromTasksData(int index) {
    tasksBox.deleteAt(index);
  }
}
