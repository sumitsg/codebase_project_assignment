import 'package:codebase_project_assignment/feature/user_list/data/model/user_list_model.dart';
import 'package:hive/hive.dart';

class HiveService {
  static const String _userBox = "userBox";

  /// Save users into Hive (Merge with existing users)
  Future<void> saveUsers(List<UserData> newUsers) async {
    var box = await Hive.openBox<UserData>(_userBox);

    // Get existing users
    List<UserData> existingUsers = box.values.toList();

    // Convert list to a Map for easier merging (Avoid duplicates)
    Map<int, UserData> userMap = {
      for (var user in existingUsers)
        if (user.id != null) user.id!: user
    };

    // Add/Update new users in the map
    for (var user in newUsers) {
      if (user.id != null) {
        userMap[user.id!] = user;
      }
    }

    // Store updated list in Hive
    await box.clear(); // Clear old data
    await box.putAll(userMap); // Store merged data
  }

  /// Retrieve users from Hive
  Future<List<UserData>> getUsers() async {
    var box = await Hive.openBox<UserData>(_userBox);
    return box.values.toList(); // Get all stored users
  }
}
