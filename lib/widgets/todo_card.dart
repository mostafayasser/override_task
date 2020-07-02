import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Data/data.dart';
import '../helpers/routes.dart';
import '../models/todoItem.dart';


class ToDoCard extends StatefulWidget {
  final title;
  final done;
  ToDoCard({this.title, this.done});
  @override
  _ToDoCardState createState() => _ToDoCardState();
}

class _ToDoCardState extends State<ToDoCard> {
  final data = Data();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(editItemScreenRoute , arguments: TodoItem(title: widget.title, done: widget.done)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Checkbox(
                value: widget.done,
                onChanged: (value) {
                  Provider.of<Data>(context, listen: false).toggleDone(
                      TodoItem(title: widget.title, done: widget.done));
                },
                checkColor: Colors.black,
              ),
              Text("${widget.title}"),
            ],
          ),
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => Provider.of<Data>(context, listen: false)
                  .deleteItem(TodoItem(title: widget.title, done: widget.done)))
        ],
      ),
    );
  }
}
