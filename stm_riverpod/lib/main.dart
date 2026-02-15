import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:stm_riverpod/section_2/lesson_4/video_1.dart';
import 'package:stm_riverpod/section_2/lesson_5/video_2.dart';
import 'package:stm_riverpod/section_2/state_notifier/counter_example/counter_screen.dart';



void main() {
  runApp(ProviderScope(child:MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:CounterScreen()
    );
  }
}
