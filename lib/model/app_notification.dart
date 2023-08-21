import 'package:diabuddy/model/enitity/enum/notification_type.dart';
import 'package:equatable/equatable.dart';

class AppNotification extends Equatable {
  const AppNotification({
    required this.triggerTime,
    required this.notificationType,
    this.therapyId,
    this.id,
  });

  final DateTime triggerTime;
  final NotificationType notificationType;
  final String? therapyId;
  final String? id;

  @override
  List<Object?> get props => [triggerTime, notificationType];

  factory AppNotification.fromMap(map, String id) {
    return AppNotification(
      id: id,
      triggerTime: map['triggerTime'].toDate(),
      notificationType: NotificationType.values[map['notificationType']],
      therapyId: map['therapyId'],
    );
  }

  Map<String, dynamic> toMap() {
    var data = {
      'triggerTime': triggerTime,
      'notificationType': notificationType.index,
    };
    if (therapyId != null) data['therapyId'] = therapyId!;
    return data;
  }
}
