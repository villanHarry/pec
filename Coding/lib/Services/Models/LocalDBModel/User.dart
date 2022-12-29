import 'package:hive/hive.dart';
part 'User.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  late String email;
  @HiveField(1)
  late String fullname;
  @HiveField(2)
  late String image;
}
