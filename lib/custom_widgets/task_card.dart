import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mytasks/objects/to_do_item.dart';
import 'package:mytasks/theme/pallete.dart';

class TaskCard extends StatefulWidget {
  const TaskCard(
      {super.key,
      required this.index,
      required this.deleteTask,
      required this.changeIsCompleted});

  // final ToDoItem item;
  final int index;
  final Function(BuildContext)? deleteTask;
  final Function()? changeIsCompleted;
  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  var tasksBox = Hive.box('tasksbox');
  late var currentTask;
  @override
  Widget build(BuildContext context) {
    currentTask = tasksBox.getAt(widget.index) as ToDoItem;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onDoubleTap: widget.changeIsCompleted,
        child: Slidable(
          endActionPane: ActionPane(
            motion: const StretchMotion(),
            children: <Widget>[
              SlidableAction(
                autoClose: true,
                backgroundColor: Pallete.changedTheme == true
                    ? Pallete.blackColor
                    : Pallete.whiteColor,
                foregroundColor: Pallete.changedTheme == true
                    ? Pallete.whiteColor
                    : Pallete.blackColor,
                onPressed: widget.deleteTask,
                icon: Icons.delete_forever_rounded,
              ),
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.0,
                color: Pallete.changedTheme == true
                    ? Pallete.whiteColor
                    : Pallete.blackColor,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  currentTask.itemName,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    decorationThickness: 2.0,
                    decorationColor: Pallete.blackColor,
                    decoration: currentTask.isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
