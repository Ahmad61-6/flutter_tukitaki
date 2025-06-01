import 'package:equatable/equatable.dart';

class ToDoState extends Equatable {
  final List<String> todos;

  const ToDoState({this.todos = const []});
  @override
  // TODO: implement props
  List<Object?> get props => [todos];
}
