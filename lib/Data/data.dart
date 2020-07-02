import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';
import '../models/todoItem.dart';

class Data extends ChangeNotifier {
  static User _user;
  final _firestore = Firestore.instance;
  getData({email}) async {
    List<TodoItem> todoItems = [];
    if (_user == null) {
      setUser(User(email: email, items: todoItems));
    }
    var documents = await _firestore.collection(email).getDocuments();
    if (documents != null) {
      documents.documents.forEach((element) {
          todoItems.add(TodoItem(title: element.data['title'], done: element.data['done']));
          setUser(User(email: email, items: todoItems));
          
        });

      
    } 
    
  }

  addItem(title) async {

    await _firestore.collection(_user.email).document(title).setData({
      'title': title,
      'done': false,
    });
    _user.items.add(TodoItem(title: title, done: false));
    notifyListeners();
  }

  setUser(user) {

    _user = user;
    notifyListeners();
  }

   getUser() {
    return _user;
  }

  String get email {
    return _user.email;
  }

  toggleDone(item) async {
    await _firestore.collection(_user.email).document(item.title).updateData({
      'done': !item.done,
    });
    _user.items.forEach((element) {
      if(element.title == item.title){
        element.done = !item.done;
      }
    });

    notifyListeners();
  }
  

  deleteItem(TodoItem item) async{
   await  _firestore.collection(_user.email).document(item.title).delete();
    _user.items.remove(item);
      notifyListeners();

  }

  editItem(item , newValue) async {
    await _firestore.collection(_user.email).document(newValue).setData({
      'title': newValue,
      'done' : item.done
    });
    final index = _user.items.indexOf(item);
    deleteItem(item);
    _user.items.insert(index,TodoItem(title: newValue, done: item.done));
   
   
  }
}
