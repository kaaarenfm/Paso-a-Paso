import '../../domain/models/onboarding_model.dart';

class OnboardingController {
  OnboardingModel model = OnboardingModel();

  void setObjective(String value) {
    model.objective = value;
  }

  void setCategories(List<String> values) {
    model.categories = values;
  }

  void setLevel(String value) {
    model.level = value;
  }

  void setSchedule(String value) {
    model.schedule = value;
  }

  void setMotivation(String value) {
    model.motivation = value;
  }
}
