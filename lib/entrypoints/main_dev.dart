import 'package:codebase_project_assignment/flavors/flavor_config.dart';
import 'package:codebase_project_assignment/flavors/flavor_enum.dart';
import 'package:codebase_project_assignment/flavors/flavor_values.dart';
import 'package:codebase_project_assignment/main_common.dart';

void main() {
  mainCommon(
      flavor: Flavor.dev,
      flavorValues: const FlavorValues(
        appTitle: "Codebase Project Assignment Dev",
        apiBaseUrl: "https://reqres.in-dev/api",
      ));
}
