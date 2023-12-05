import 'package:floor/floor.dart';

@entity
class Todo { //table
  @primaryKey
  int id;
  String task;
  Todo(this.id, this.task);
}