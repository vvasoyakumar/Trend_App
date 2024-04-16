import 'package:intl/intl.dart';

String getDateFormat({required DateTime? date}) {
  if (date != null) {
    return DateFormat.yMd().add_jm().format(date);
  } else {
    return "-";
  }
}

String getDateFormatMMMd({required DateTime? date}) {
  if (date != null) {
    return DateFormat("MMM d").format(date);
  } else {
    return "-";
  }
}
