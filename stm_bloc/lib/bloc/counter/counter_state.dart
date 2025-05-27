import 'package:equatable/equatable.dart';

class CounterState extends Equatable {
  final int counter;
  bool color;

  CounterState({this.counter = 0, this.color = true});

  CounterState copyWith({int? counter, bool? color}) {
    return CounterState(
      counter: counter ?? this.counter,
      color: color ?? this.color,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
