import 'package:flutter/material.dart';

class DefaultScreen extends StatefulWidget {
  static const String routeName = "/default_screen";
  const DefaultScreen({super.key});

  @override
  State<DefaultScreen> createState() => _DefaultScreenState();
}

class _DefaultScreenState extends State<DefaultScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("opps.. Wrong route"),
      ),
    );
  }
}
