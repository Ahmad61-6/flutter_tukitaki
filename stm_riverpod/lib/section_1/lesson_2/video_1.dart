import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final counterProvider  = StateProvider((Ref ref){
  return 0;
});

class StateProviderTutorial extends ConsumerWidget {
  const StateProviderTutorial({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref
      ) {
    print("-----loaded");
    return MaterialApp(
        home: Scaffold(
        appBar:
        AppBar(
          title: Text("State Provider Tutorial"),
        ),
       floatingActionButton: IconButton(onPressed: (){
         ref.read(counterProvider.notifier).state++;
       }, icon: Icon(Icons.add)),
        body: Center(
          child:
              Consumer(builder: (context, ref, child){
                print("----- consumer loaded");
                final counter = ref.watch(counterProvider);
                return  Text(counter.toString());
              })

        ),
      ),
    );
  }
}
