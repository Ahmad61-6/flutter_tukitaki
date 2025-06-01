import 'package:bloc/bloc.dart';
import 'package:stm_bloc/bloc/todo/to_do_event.dart';
import 'package:stm_bloc/bloc/todo/to_do_state.dart';

class ToDoBloc extends Bloc<ToDoEvents, ToDoState> {
  ToDoBloc() : super(const ToDoState()) {}
}
