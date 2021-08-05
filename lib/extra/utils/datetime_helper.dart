import 'package:jiffy/jiffy.dart';

extension DateTimeParsing on DateTime {
  String formattedString() {
    return Jiffy(this).yMMMEd;
  }

  String formattedStringWithTime() {
    return Jiffy(this).format('MMMM dd yyyy hh:mm');
  }
}
