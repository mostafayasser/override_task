import 'package:equatable/equatable.dart';

class TodoItem extends Equatable{
  bool done;
  String title;
  TodoItem({this.done, this.title});

  @override
  List<Object> get props => [title];
}


