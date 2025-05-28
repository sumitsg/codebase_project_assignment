import 'package:codebase_project_assignment/feature/user_list/presentation/flutter_app.dart';
import 'package:codebase_project_assignment/flavors/flavor_config.dart';
import 'package:codebase_project_assignment/flavors/flavor_enum.dart';
import 'package:codebase_project_assignment/flavors/flavor_values.dart';
import 'package:flutter/material.dart';

void mainCommon({required FlavorValues flavorValues, required Flavor flavor}) {
  FlavorConfig.initialize(flavor: flavor, values: flavorValues);
  runApp(const FlutterApp());
}
