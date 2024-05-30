
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/models/user_model.dart';
import '../../features/home/data/models/todo_model.dart';

class CacheHelper {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String getToken() {
    return _prefs.getString("token") ?? "";
  }
  static String getEmail(){
    return _prefs.getString("email") ?? "";
  }



  static String getFirstName() {
    return _prefs.getString("firstname") ?? "";
  }

  static String getPhone() {
    return _prefs.getString("phone") ?? "";
  }

  static String getLastName() {
    return _prefs.getString('lastname') ?? "";
  }
  static String getUserName() {
    return _prefs.getString('username') ?? "";
  }

  static String gender() {
    return _prefs.getString("gender") ?? "";
  }

  static int getId() {
    return int.parse(_prefs.getString("id") ?? "0");
  }

  static Future saveLoginData(UserModel user) async {
    await _prefs.setString("image", user.image);
    await _prefs.setInt("id", user.id);
    await _prefs.setString("email", user.email);
    await _prefs.setString("firstname", user.firstName);
    await _prefs.setString("token", user.token);
    await _prefs.setString("lastname", user.lastName);
    await _prefs.setString("username", user.userName);
    await _prefs.setString("gender", user.gender);

  }

  static Future removeLoginData() async {
    await _prefs.clear();
  }

  static Future<void> initialiseHive() async {
    const todosKey = 'todos';

    Hive.registerAdapter(TodoModelAdapter());
    Hive.registerAdapter(TodosAdapter());
     await Hive.openBox<TodoModel?>(todosKey);

  }

}

