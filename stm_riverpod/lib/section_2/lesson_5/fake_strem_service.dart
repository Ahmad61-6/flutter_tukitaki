import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final timerService = Provider((_) => TimerService());
class TimerService{
  Stream<int> tick(){
    return Stream.periodic(Duration(seconds: 1), (count) => count);
  }

  Stream<int> tickError() async*{
    for(int i = 0 ; i < 5 ; i++){
      await Future.delayed(Duration(seconds: 1));
      yield i;
    }
    throw Exception("Something went wrong");
  }
}
