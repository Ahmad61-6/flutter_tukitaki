import 'package:flutter_riverpod/legacy.dart';
import 'package:stm_riverpod/section_2/state_notifier/todo_example/todo_model.dart';

final todoProvider = StateNotifierProvider<TodoProviderController, List<Todo>>((ref)=> TodoProviderController([]));



    class TodoProviderController extends StateNotifier<List<Todo>>{
  TodoProviderController(super.state);

  void addTodo(String title){
    final newTodo = Todo(id: state.isEmpty ? 0 : state.last.id+1, title: title, isCompleted: false);
    state = [...state, newTodo];
  }

void remove(int id){
    state = state.where((todo) => todo.id != id).toList();
}
void update(int id, String title){
    final todos = [...state];
    final index = todos.indexWhere((todo) => todo.id == id);
    if(index == -1) return;
    todos[index] = todos[index].copyWith(title: title);
    state = todos;

}
void toggle(int id){
    final todos = [...state];
    final index = todos.indexWhere((todo) => todo.id == id);
    if(index == -1) return;
    todos[index] = todos[index].copyWith(isCompleted: !todos[index].isCompleted);
    state = todos;

}

  }
