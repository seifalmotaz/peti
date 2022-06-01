import 'package:petiapp/models/pet.dart';

class Request {
  Request({
    required this.sender,
    required this.receiver,
    required this.isAccepted,
    required this.isCompleted,
    required this.createdAt,
    required this.id,
  });

  Pet sender;
  Pet receiver;
  bool? isAccepted;
  bool isCompleted;
  String createdAt;
  String id;

  factory Request.fromMap(Map<String, dynamic> json) => Request(
        sender: Pet.fromMap(json["sender"]),
        receiver: Pet.fromMap(json["receiver"]),
        isAccepted: json["is_accepted"],
        isCompleted: json["is_completed"],
        createdAt: json["created_at"],
        id: json["id"],
      );
}
