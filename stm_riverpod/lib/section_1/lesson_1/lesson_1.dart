import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final staticStringProvider = Provider((Ref ref){
  return "Hello world";
});
final intProvider = Provider((Ref ref){
  return 1;
});


class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final result = ref.watch(staticStringProvider);
    final intResult = ref.watch(intProvider);
    return MaterialApp(
      home: Scaffold(
        body: Center(child: Text(result + " "+ intResult.toString()),),
      ),
    );
  }
}


