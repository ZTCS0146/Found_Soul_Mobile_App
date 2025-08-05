import 'package:hive/hive.dart';

part 'notification_model.g.dart';

@HiveType(typeId: 0)
class MyNotification extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String body;

  @HiveField(2)
  DateTime receivedAt;

  @HiveField(3)
  String? imageUrl; // Optional image support

  MyNotification({
    required this.title,
    required this.body,
    required this.receivedAt,
    this.imageUrl,
  });
}
