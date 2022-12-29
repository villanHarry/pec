import '../../../Constants/Imports.dart';

class Boxes {
  static Box<User> getUser() => Hive.box<User>('User');
}
