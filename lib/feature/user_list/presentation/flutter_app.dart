import 'package:codebase_project_assignment/flavors/flavor_config.dart';
import 'package:flutter/material.dart';

class FlutterApp extends StatefulWidget {
  const FlutterApp({super.key});

  @override
  State<FlutterApp> createState() => _FlutterAppState();
}

class _FlutterAppState extends State<FlutterApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter App Flavor ${FlavorConfig.instance.flavor}'),
        ),
        body: Center(
          child: Text('Base URL :- ${FlavorConfig.instance.values.apiBaseUrl}'),
        ),
      ),
    );
  }
}
