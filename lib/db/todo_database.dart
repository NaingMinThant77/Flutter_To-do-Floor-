import 'package:floor/floor.dart';
import 'package:todo_floor/db/todo.dart';
import 'package:todo_floor/db/todo_dao.dart';

import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'todo_database.g.dart';
@Database(version: 1, entities: [Todo])
abstract class TodoDatabase extends FloorDatabase {
  TodoDao get todoDao;
}