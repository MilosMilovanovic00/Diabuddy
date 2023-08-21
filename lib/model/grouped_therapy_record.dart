class GroupedTherapyRecord {
  final String therapyName;
  final bool isInsulin;
  late final int count;

  GroupedTherapyRecord({
    required this.therapyName,
    required this.isInsulin,
    required this.count,
  });

  void incrementCount() {
    count+=1;
  }
}
