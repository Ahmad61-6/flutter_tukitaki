import 'package:flutter/material.dart';

class BlogEditor extends StatelessWidget {
  final TextEditingController teContoller;
  final String hintText;

  const BlogEditor({
    super.key,
    required this.teContoller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: teContoller,
      decoration: InputDecoration(hintText: hintText),
      maxLines: null,
    );
  }
}
