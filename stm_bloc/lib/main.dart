import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stm_bloc/bloc/counter/counter_bloc.dart';
import 'package:stm_bloc/bloc/switch_example/switch_bloc.dart';
import 'package:stm_bloc/ui/screens/counter_screen.dart';
import 'package:stm_bloc/utils/image_picker_utils.dart';

import 'bloc/image_picker/image_picker_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CounterBloc()),
        BlocProvider(create: (_) => SwitchBloc()),
        BlocProvider(
          create: (_) => ImagePickerBloc(imagePickerUtils: ImagePickerUtils()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: CounterScreen(),
      ),
    );
  }
}
