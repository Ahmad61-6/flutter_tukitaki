import 'package:flutter/material.dart';

import '../../../shared/widgets/auth/auth_scaffold_background.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AuthScaffoldBackground(),
          Positioned(
            top: 140,
            bottom: 100,
            left: 30,
            right: 30,
            child: Card(
              color: Colors.white,
              child: Column(children: []),
            ),
          ),
        ],
      ),
    );
  }
}
