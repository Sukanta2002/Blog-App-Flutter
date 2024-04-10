import 'package:intl/intl.dart';

String dateTimeConverter(DateTime dateTime) {
  return DateFormat("d MMM, yyyy").format(dateTime);
}
