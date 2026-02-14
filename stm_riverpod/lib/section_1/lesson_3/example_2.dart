import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final durationProvider = Provider((Ref ref){
  return const Duration(seconds: 2);
});


class AnimationExam extends ConsumerStatefulWidget {
  const AnimationExam({super.key});

  @override
  ConsumerState<AnimationExam> createState() => _AnimationState();
}

class _AnimationState extends ConsumerState<AnimationExam> with SingleTickerProviderStateMixin{
  late final AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final duration = ref.read(durationProvider);
    _controller = AnimationController(vsync: this, duration: duration)..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pulsing circle"),
      ),
      body: Center(
        child:
        ScaleTransition(scale: _controller.drive(Tween(begin: 0.5,end: 1.5)),
        child: const Icon(Icons.circle,color: Colors.red,size: 100),),
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
}
