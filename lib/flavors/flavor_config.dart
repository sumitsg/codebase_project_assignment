import 'package:codebase_project_assignment/flavors/flavor_enum.dart';
import 'package:codebase_project_assignment/flavors/flavor_values.dart';

class FlavorConfig {
  final Flavor flavor;
  final FlavorValues values;

  static late FlavorConfig _instance;
  static bool _initialize = false;

  factory FlavorConfig.initialize(
      {required Flavor flavor, required FlavorValues values}) {
    if (!_initialize) {
      _instance = FlavorConfig._internal(flavor: flavor, values: values);
      _initialize = true;
    }
    return _instance;
  }

  FlavorConfig._internal({
    required this.flavor,
    required this.values,
  });

  static FlavorConfig get instance {
    if (!_initialize) {
      throw Exception("FlavorConfig not initialized");
    }
    return _instance;
  }

  static bool isPROD() => _instance.flavor == Flavor.prod;

  static bool isStaging() => _instance.flavor == Flavor.staging;

  static bool isDEV() => _instance.flavor == Flavor.dev;
}
