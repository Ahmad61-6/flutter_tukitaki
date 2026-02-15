import 'package:flutter_riverpod/legacy.dart';

class CounterProviderController extends StateNotifier<int>{
  CounterProviderController(super.state);
  void increment()=> state++;
  void decrement()=> state--;
  void resetCounter()=> state = 0;
}

final counterProvider = StateNotifierProvider<CounterProviderController, int>((_){
return CounterProviderController(0);


});