import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mytasks/objects/to_do_item.dart';
import 'package:mytasks/pages/home_page.dart';
import 'package:mytasks/providers/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ToDoItemAdapter());
  var box = await Hive.openBox('tasksbox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ((context) => ThemeProvider()),
      builder: ((context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: Provider.of<ThemeProvider>(context).theme,
          home: const HomePage(),
        );
      }),
    );
  }
}
