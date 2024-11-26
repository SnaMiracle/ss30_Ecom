import 'package:flutter/material.dart';


class ECircularLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoaderScreen(),
    );
  }
}

class LoaderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Circular Loader Example"),
      ),
      body: const Center(
        child: CircularProgressIndicator(), // Circular loader
      ),
    );
  }
}