import 'package:equatable/equatable.dart';

abstract class ToDoEvents extends Equatable {
  const ToDoEvents();
  @override
  List<Object?> get props => [];
}

class AddTodo extends ToDoEvents {}

class RemoveTodo extends ToDoEvents {}
