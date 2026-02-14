import 'dart:math';

class FakeApiService {
  Future<String> fetchGreetings() async{
    await Future.delayed(Duration(seconds: 2));
    if(Random().nextDouble() < 0.3){
      throw Exception("Something went wrong");
    }
    return "Hello world";
    }

  }
