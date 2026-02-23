import 'package:flutter/material.dart';

class RoadAssistPage extends StatefulWidget {
  const RoadAssistPage({super.key});

  @override
  State<RoadAssistPage> createState() => _RoadAssistPageState();
}

class _RoadAssistPageState extends State<RoadAssistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Road Assist Page"),
      ),
    );
  }
}
