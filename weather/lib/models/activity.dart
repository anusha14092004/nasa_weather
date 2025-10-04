enum ActivityPreset { hiking, fishing, beach }

class ActivityScore {
  ActivityPreset activity;
  double score;

  ActivityScore({required this.activity, required this.score});

  String activityName() {
    switch (activity) {
      case ActivityPreset.hiking: return "Hiking";
      case ActivityPreset.fishing: return "Fishing";
      case ActivityPreset.beach: return "Beach";
    }
  }
}
