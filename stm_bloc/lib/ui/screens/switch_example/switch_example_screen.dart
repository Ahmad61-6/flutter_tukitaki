import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stm_bloc/bloc/switch_example/switch_bloc.dart';
import 'package:stm_bloc/bloc/switch_example/switch_event.dart';

import '../../../bloc/switch_example/switch_state.dart';

class SwitchExampleScreen extends StatefulWidget {
  const SwitchExampleScreen({super.key});

  @override
  State<SwitchExampleScreen> createState() => _SwitchExampleScreenState();
}

class _SwitchExampleScreenState extends State<SwitchExampleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Switch Example",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
        toolbarHeight: 35,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocBuilder<SwitchBloc, SwitchState>(
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Enable Notification",
                        style: TextStyle(fontSize: 30),
                      ),
                      Switch(
                        activeColor: Colors.white,
                        activeTrackColor: Colors.green,
                        value: state.isSwitched,
                        onChanged: (value) {
                          context.read<SwitchBloc>().add(
                            EnableOrDisableNotification(),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              BlocBuilder<SwitchBloc, SwitchState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 180,
                        decoration: BoxDecoration(
                          color: Colors.red.withValues(
                            alpha: state.sliderValue,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Slider(
                        activeColor: Colors.green,
                        value: state.sliderValue,
                        onChanged: (value) {
                          context.read<SwitchBloc>().add(
                            SliderEvent(sliderValue: value),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
