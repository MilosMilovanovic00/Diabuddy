class TherapyRecord {
  final String therapyName;
  final bool isInsulin;
  final DateTime time;

  TherapyRecord({
    required this.therapyName,
    required this.isInsulin,
    required this.time,
  });

  factory TherapyRecord.fromMap(Map<String, dynamic> map) {
    return TherapyRecord(
      therapyName: map['therapyName'],
      isInsulin: map['isInsulin'],
      time: map['time'].toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'therapyName': therapyName,
      'isInsulin': isInsulin,
      'time': time,
    };
  }
}
