import 'package:diabuddy/model/enitity/enum/activity_type.dart';
import 'package:equatable/equatable.dart';

class Activity extends Equatable {
  final String name;
  final ActivityIntensity intensity;
  final int duration;

  const Activity({
    required this.name,
    required this.intensity,
    required this.duration,
  });

  @override
  List<Object?> get props => [
        name,
        intensity,
        duration,
      ];

  factory Activity.fromMap(map) {
    return Activity(
      name: map['name'],
      intensity: ActivityIntensity.values[map['intensity']],
      duration: map['duration'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'intensity': intensity.index,
      'duration': duration,
    };
  }
}
