import 'package:flutter/foundation.dart';

class Task with ChangeNotifier {
  final String id;
  final String title;
  final String description;


  Task({
    required this.id,
    required this.title,
    required this.description,
  });
}
