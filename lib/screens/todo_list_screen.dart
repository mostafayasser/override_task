import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Data/data.dart';
import '../helpers/routes.dart';
import '../models/ThemeNotifier.dart';
import '../models/auth.dart';
import '../widgets/todo_card.dart';

class TodoListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final user = Provider.of<Data>(context).getUser();

    Widget body() {
      if (user.items == null) {
        return Center(child: CircularProgressIndicator());
      } else if (user.items.isEmpty) {
        return Center(
          child: Text("Add items"),
        );
      } else {
        return ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: MediaQuery.of(context).size.height),
            child: ListView.builder(
              itemCount: user.items.length,
              itemBuilder: (ctx, i) => ToDoCard(
                title: user.items[i].title,
                done: user.items[i].done,
              ),
            ));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("ToDo List"),
        actions: [
          FlatButton(
            child: Text("Dark mode"),
            onPressed: () {},
          ),
          Platform.isIOS
              ? CupertinoSwitch(
                  value: theme.getTheme() == darkTheme,
                  onChanged: (value) => value
                      ? theme.setTheme(darkTheme)
                      : theme.setTheme(lightTheme))
              : Switch(
                  value: theme.getTheme() == darkTheme,
                  onChanged: (value) => value
                      ? theme.setTheme(darkTheme)
                      : theme.setTheme(lightTheme)),
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                signOut();
                Navigator.of(context).pushReplacementNamed(signInScreenRoute);
              })
        ],
      ),
      body: body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(addItemScreenRoute),
        child: Icon(Icons.add),
      ),
    );
  }
}
