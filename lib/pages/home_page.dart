import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mytasks/constants/constants.dart';
import 'package:mytasks/custom_widgets/task_card.dart';
import 'package:mytasks/objects/to_do_item.dart';
import 'package:mytasks/providers/theme_provider.dart';
import 'package:mytasks/data_manager.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController taskTextEditingController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    var tasksBox = Hive.box('tasksbox');
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.dark_mode_rounded),
          onPressed: () {
            Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
          },
        ),
        title: const Text(
          'My Tasks',
          style: kAppTitleTextStyle,
        ),
        centerTitle: true,
        actions: const [Icon(Icons.delete_outline_rounded)],
      ),
      body: ReorderableListView.builder(
        itemBuilder: ((context, index) {
          return ValueListenableBuilder(
              key: ValueKey(tasksBox.getAt(index)),
              valueListenable: tasksBox.listenable(),
              builder: ((context, value, child) {
                return TaskCard(
                  deleteTask: (context) {
                    setState(() {
                      DataManager.removeTaskFromTasksData(index);
                    });
                  },
                  index: index,
                  changeIsCompleted: () {
                    var currentTask = tasksBox.getAt(index) as ToDoItem;
                    currentTask.changeIsCompletedValue();
                    tasksBox.putAt(index, currentTask);
                  },
                );
              }));
        }),
        itemCount: tasksBox.length,
        onReorder: (int oldIndex, int newIndex) {
          DataManager.reorderListView(oldIndex, newIndex);
        },
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 5,
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 50.0,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            showDialog(
                context: context,
                builder: ((context) => AlertDialog(
                      backgroundColor: Theme.of(context).backgroundColor,
                      content: TextField(
                        autofocus: true,
                        controller: taskTextEditingController,
                        decoration: kAlertDialogInputDecoration,
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              String textFieldText =
                                  taskTextEditingController.text;
                              if (textFieldText != '') {
                                DataManager.addToTasksData(textFieldText);
                              }
                            });
                            taskTextEditingController.text = '';
                            Navigator.pop(context);
                          },
                          child: const Text('Save'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            taskTextEditingController.text = '';
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                      ],
                    )));
          });
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
