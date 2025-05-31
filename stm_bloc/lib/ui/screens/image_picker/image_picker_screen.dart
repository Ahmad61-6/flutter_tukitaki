import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stm_bloc/bloc/image_picker/image_picker_bloc.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Image Picker",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.pink,
      ),
      body: Center(
        child: BlocBuilder<ImagePickerBloc, ImagePickerState>(
          builder: (context, state) {
            if (state.file == null) {
              return InkWell(
                onTap: () {
                  context.read<ImagePickerBloc>().add(CameraCapture());
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    color: Colors.pink,
                  ),
                  child: CircleAvatar(
                    maxRadius: 40,
                    minRadius: 40,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.add_a_photo_outlined,
                      color: Colors.pink,
                      size: 30,
                    ),
                  ),
                ),
              );
            } else {
              return Image.file(File(state.file!.path.toString()));
            }
          },
        ),
      ),
    );
  }
}
