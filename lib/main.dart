import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mytasks/objects/to_do_item.dart';
import 'package:mytasks/pages/home_page.dart';
import 'package:mytasks/providers/theme_provider.dart';
import 'package:mytasks/theme/pallete.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ToDoItemAdapter());
  var box = await Hive.openBox('tasksbox');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (!prefs.containsKey('isDark')) {
    await prefs.setBool('isDark', false);
  }
  bool isDark = prefs.getBool('isDark')!;
  Pallete.changedTheme = isDark;
  return runApp(ChangeNotifierProvider(
    create: ((context) => ThemeProvider(isDark: isDark)),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: themeProvider.theme,
          home: const HomePage(),
        );
      },
    );
  }
}
