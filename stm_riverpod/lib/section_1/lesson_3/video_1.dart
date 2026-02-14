import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final textProvider = StateProvider((Ref ref){
  return '';
});

class StatefulConsumerTutorial extends ConsumerStatefulWidget {
  const StatefulConsumerTutorial({super.key});

  @override
  ConsumerState<StatefulConsumerTutorial> createState() => _StatefulConsumerTutorialState();
}

class _StatefulConsumerTutorialState extends ConsumerState<StatefulConsumerTutorial> {
 late final TextEditingController textController;

  @override
  void initState() {

    super.initState();
    textController = TextEditingController();
    textController.addListener((){
      ref.read(textProvider.notifier).state = textController.text;
    });

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Text form"),
      ),
      body: Padding(padding: EdgeInsets.all(12),
      child: Column(
        children: [
          TextFormField(
            controller: textController ,
          ),
          const SizedBox(
            height: 20,
          ),
       Consumer(builder: (builder, ref, child){
         final text = ref.watch(textProvider);
         return    Text("You typed: $text");})
        ],
      ),),
    );
  }
  @override
  void dispose() {

    super.dispose();
    textController.dispose();
  }
}
