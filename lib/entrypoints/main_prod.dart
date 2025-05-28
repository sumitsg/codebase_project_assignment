import 'package:codebase_project_assignment/flavors/flavor_config.dart';
import 'package:codebase_project_assignment/flavors/flavor_enum.dart';
import 'package:codebase_project_assignment/flavors/flavor_values.dart';
import 'package:codebase_project_assignment/main_common.dart';

void main() {
  mainCommon(
      flavor: Flavor.prod,
      flavorValues: const FlavorValues(
        appTitle: "Codebase Project Assignment",
        apiBaseUrl: "https://reqres.in/api",
      ));
}
