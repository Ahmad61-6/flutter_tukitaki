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
                  imagePickerDialogue(context);
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
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    InkWell(
                      child: Image.file(File(state.file!.path.toString())),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          imagePickerDialogue(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          "Upload image",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Future<dynamic> imagePickerDialogue(BuildContext context) {
    return showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text(
              "Choose",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            content: SizedBox(
              height: 100,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          context.read<ImagePickerBloc>().add(CameraCapture());
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey,
                          size: 40,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Camera",
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          context.read<ImagePickerBloc>().add(
                            GalleryImagePicker(),
                          );
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.photo, color: Colors.grey, size: 40),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Gallery",
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
    );
  }
}
