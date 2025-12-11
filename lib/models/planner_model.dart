class Planner {
  final String id;
  final String recipeId;
  final String recipeTitle;
  final DateTime schedule;
  final bool notificationEnabled;

  Planner({
    required this.id,
    required this.recipeId,
    required this.recipeTitle,
    required this.schedule,
    required this.notificationEnabled,
  });

  factory Planner.fromJson(Map<String, dynamic> json) {
    return Planner(
      id: json['id'] ?? '',
      recipeId: json['recipeId'] ?? '',
      recipeTitle: json['recipeTitle'] ?? '',
      schedule: DateTime.parse(json['schedule']),
      notificationEnabled: json['notificationEnabled'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'recipeId': recipeId,
      'recipeTitle': recipeTitle,
      'schedule': schedule.toIso8601String(),
      'notificationEnabled': notificationEnabled,
    };
  }
}