import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Data/data.dart';


class AddItemScreen extends StatelessWidget {

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add item"),
      ),
      body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.05),
            child: TextField(
              decoration: InputDecoration(hintText: "Add title here"),
              controller: _controller,
            ),
          ),
          RaisedButton(onPressed: () {
            Provider.of<Data>(context, listen: false).addItem(_controller.text);
            Navigator.of(context).pop();

          } , child: Text("Add"))
        ],
      ),
      ),
    );
  }
}