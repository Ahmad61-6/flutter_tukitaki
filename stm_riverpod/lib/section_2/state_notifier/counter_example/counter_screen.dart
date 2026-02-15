import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stm_riverpod/section_2/state_notifier/counter_example/counter_provider_controller.dart';

class CounterScreen extends ConsumerStatefulWidget {
  const CounterScreen({super.key});

  @override
  ConsumerState<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends ConsumerState<CounterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: .min,
          children: [
            
            Consumer(builder: (context,ref,child){
              final counter = ref.watch(counterProvider);
              return Text(counter.toString(),style: Theme.of(context).textTheme.headlineMedium,);
            })
          ],)
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            FloatingActionButton(onPressed: () => ref.read(counterProvider.notifier).increment(),child: Icon(Icons.add),),
            FloatingActionButton(onPressed: () => ref.read(counterProvider.notifier).resetCounter(),child: Icon(Icons.refresh),),
            FloatingActionButton(onPressed: () => ref.read(counterProvider.notifier).decrement(),child: Icon(Icons.remove),),
          ],
        ),
      ),
    );
  }
}
