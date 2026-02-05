import 'package:clean_arch_blog_app/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_sizer.dart';

class AddNewBlogPage extends StatefulWidget {
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Add New Blog',
        showBackButton: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.done_rounded, size: 30.r),
          ),
        ],
      ),
    );
  }
}
