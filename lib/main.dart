import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './Data/data.dart';
import './helpers/routes.dart';
import './models/ThemeNotifier.dart';
import './screens/signin_screen.dart';
import './screens/todo_list_screen.dart';
import './screens/add_item_screen.dart';
import './screens/edit_item_screen.dart';
import './screens/main_screen.dart';


void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ThemeNotifier(darkTheme)),
      ChangeNotifierProvider(create: (_) => Data()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      title: 'Override',
      theme: theme.getTheme(),
      home: MainScreen(),
      routes: {
        signInScreenRoute : (ctx) => SigninScreen(),
        todoListScreenRoute : (ctx) => TodoListScreen(),
        addItemScreenRoute : (ctx) => AddItemScreen(),
        editItemScreenRoute : (ctx) => EditItemScreen(),
      },
    );
  }
}
