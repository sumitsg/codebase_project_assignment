import 'package:codebase_project_assignment/feature/user_list/domain/entity/user_entity.dart';
import 'package:codebase_project_assignment/feature/user_list/presentation/screens/default_scree.dart';
import 'package:codebase_project_assignment/feature/user_list/presentation/screens/user_detailed_page.dart';
import 'package:codebase_project_assignment/feature/user_list/presentation/screens/user_listing_screen.dart';
import 'package:codebase_project_assignment/splash_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case UserListingScreen.routeName:
        return MaterialPageRoute(builder: (_) => const UserListingScreen());

      case SplashScreen.routeName:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case UserDetailedPage.routeName:
        return MaterialPageRoute(
            builder: (_) => UserDetailedPage(
                  userInformation: settings.arguments as UserDataEntity,
                ));
      default:
        debugPrint('Navigating to ${settings.name}');
        return MaterialPageRoute(builder: (_) => const DefaultScreen());
    }
  }
}
