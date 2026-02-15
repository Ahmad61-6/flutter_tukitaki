import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stm_riverpod/section_2/lesson_5/fake_strem_service.dart';

final tickerProvider = StreamProvider((ref){
  final service = ref.read(timerService);
  return service.tickError();
});


class TimerScreen extends ConsumerWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context , WidgetRef ref) {
    print("---build called");
    final ticket = ref.watch(tickerProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Timer"),
      ),
      body: Center(
        child: ticket.when(data: (count) => Text('Seconds elapsed: $count'), error: (e,_){
          return Text("Something went wrong..$e");
        }, loading: () => CircularProgressIndicator()),
      ),
    );
  }
}
class TimerScreen2 extends ConsumerStatefulWidget {
  const TimerScreen2({super.key});

  @override
  ConsumerState<TimerScreen2> createState() => _TimerScreen2State();
}

class _TimerScreen2State extends ConsumerState<TimerScreen2> {
  @override
  Widget build(BuildContext context) {
    print("---build called");
    return Scaffold(
      appBar: AppBar(
        title: Text("Timer"),
      ),
      body: Center(
        child: Consumer(builder: (context,ref,child){
          print('----Consumer called');
          final ticket= ref.watch(tickerProvider);
          return ticket.when(
            skipLoadingOnRefresh: false,
              data: (count) => Text('Seconds elapsed: $count'), error: (e,_){
            return Column(
               mainAxisSize: .min,
              children: [
                Text("Something went wrong..$e"),
                ElevatedButton(onPressed: ()=> ref.refresh(tickerProvider), child: Text("Retry"))
              ],
            );
          }, loading: () => CircularProgressIndicator());
        })
      ),
    );
  }
}

