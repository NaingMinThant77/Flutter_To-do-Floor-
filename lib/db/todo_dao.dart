import 'package:floor/floor.dart';
import 'package:todo_floor/db/todo.dart';

@dao
abstract class TodoDao {

  @insert
  Future<void> insertTodo(Todo todo);

  @Query("Select * from Todo")
  Stream<List<Todo>> findAllTodo();

  @Query("Select * from Todo Order by id Desc Limit 1")
  Future<Todo?> findTodoLast(); // can be null

  @Query("Delete from Todo where id = :id ")
  Future<void> deleteById(int id);

  @Query("Select * from Todo where id = :id ")
  Future<Todo?> findTodoById(int id);

  @Query("Update Todo Set task = :task where id = :id")
  Future<void> updateById(int id, String task);

  @Query("Delete from Todo")
  Future<void> deleteAll();

}