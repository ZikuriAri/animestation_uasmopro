import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({super.key, this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: const Color.fromARGB(0, 255, 255, 255),
         elevation: 0,
         ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Image.asset(
            'assets/images/nar.png',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          ),
          SafeArea(
            child: Center (
              child: child!,
            )
            ),
        ],
      ),
    );
  }
}