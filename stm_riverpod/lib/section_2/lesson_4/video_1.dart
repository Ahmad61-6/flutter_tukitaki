
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stm_riverpod/section_2/lesson_4/fake_api_service.dart';

final fakeApiProvider = Provider((_) => FakeApiService());

final greetingProvider = FutureProvider((Ref ref)async{
  final service = ref.watch(fakeApiProvider);
  return await service.fetchGreetings();
});

class GreetingsScreen extends ConsumerWidget {
  const GreetingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final greeting = ref.watch(greetingProvider);
    return
      Scaffold(
        appBar: AppBar(
          title: Text("Greetings"),
        ),
        body: Center(
          child: greeting.when(
            skipLoadingOnRefresh: false,
              data: (greeting){
            return Text(greeting);
          }, error: (error, stackTrace) =>Column(
            mainAxisSize: .min
              ,
            children: [
              Text(error.toString(),style: TextStyle(
                color: Colors.redAccent
              ),),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: ()=>ref.refresh(greetingProvider), child: Text("Retry"))
            ],
          ), loading: () => CircularProgressIndicator()),
        ),

    );
  }
}
