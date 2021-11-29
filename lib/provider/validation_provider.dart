part of 'provider.dart';

class ValidationProvider extends ChangeNotifier {
  String _errorTargetName;
  String _errorNominal;
  String _errorPeriod;

  String get errorTargetName => _errorTargetName;
  String get errorNominal => _errorNominal;
  String get errorPeriod => _errorPeriod;

  void changeTargetName(String value) {
    if (value.length == 0) {
      _errorTargetName = "Target Name Must Be Entered";
    } else {
      _errorTargetName = "";
    }

    notifyListeners();
  }

  void changeNominal(String value) {
    if (int.parse(value) < 1000) {
      _errorNominal = "Minimum nominal INR. 1000";
    } else if (value.length == 0) {
      _errorNominal = "Amount Required";
    } else {
      _errorNominal = "";
    }

    notifyListeners();
  }

  void changePeriod(String value) {
    if (int.parse(value) == 0) {
      _errorPeriod = "Should not 0";
    } else if (value.length == 0) {
      _errorPeriod = "Must be filled in";
    } else {
      _errorPeriod = "";
    }

    notifyListeners();
  }

  bool isAllHistoryValidate(String targetName) {
    if (_errorNominal == "" && targetName != null) {
      return true;
    } else {
      return false;
    }
  }

  bool isAllEditTargetValidate() {
    if (_errorTargetName == "" && _errorNominal == "" && _errorPeriod == "") {
      return true;
    } else {
      return false;
    }
  }

  bool isAllTargetValidate(String durationType, String priorityLevel) {
    if (_errorTargetName == "" &&
        _errorNominal == "" &&
        _errorPeriod == "" &&
        durationType != null &&
        priorityLevel != null) {
      return true;
    } else {
      return false;
    }
  }

  void changeAllTrue() {
    _errorTargetName = "";
    _errorNominal = "";
    _errorPeriod = "";

    notifyListeners();
  }

  void resetTargetChange() {
    _errorTargetName = null;
    _errorNominal = null;
    _errorPeriod = null;

    notifyListeners();
  }
}
