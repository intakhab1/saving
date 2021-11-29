part of 'utils.dart';

int getNominalPerDay(int nominal, int periode, String durationType) {
  switch (durationType) {
    case 'Day':
      return (nominal ~/ (periode * 1)).round();
      break;
    case 'Week':
      return (nominal ~/ (periode * 7)).round();
      break;
    case 'Month':
      return (nominal ~/ (periode * 30)).round();
      break;
    default:
      return (nominal ~/ (periode * 365)).round();
  }
}

String getPercent(int currentMoney, int nominal) {
  double result = (currentMoney * 100) / nominal;
  if (result >= 1) {
    return result.floor().toString();
  }
  return result.toStringAsFixed(1);
}

double getPercentDouble(int currentMoney, int nominal) {
  return currentMoney / nominal;
}

String generateZeroDigit(String nominal) {
  if (nominal.lastIndexOf('.') != -1) {
    return nominal.substring(0, nominal.lastIndexOf('.')) + ".000 / Day";
  }
  return nominal + " / Day";
}

String generateZeroDigitWithoutSuffix(String nominal) {
  if (nominal.lastIndexOf('.') != -1) {
    return nominal.substring(0, nominal.lastIndexOf('.')) + ".000";
  }
  return nominal;
}

String generatePeriodProgress(int startDate, int period, String durationType) {
  switch (durationType) {
    case 'Day':
      double dayTh = DateTime.fromMillisecondsSinceEpoch(startDate)
              .difference(DateTime.now())
              .inDays /
          1;
      return "$dayTh Day / $period Day";
    case 'Week':
      double weekTh = DateTime.fromMillisecondsSinceEpoch(startDate)
              .difference(DateTime.now())
              .inDays /
          7;
      return "$weekTh Week / $period Week";
    case 'Month':
      double monthTh = DateTime.fromMillisecondsSinceEpoch(startDate)
              .difference(DateTime.now())
              .inDays /
          30;
      return "$monthTh Month / $period Month";
    default:
      double yearTh = DateTime.fromMillisecondsSinceEpoch(startDate)
              .difference(DateTime.now())
              .inDays /
          365;
      return "$yearTh Year / $period Year";
  }
}
