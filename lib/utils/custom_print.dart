import 'dart:developer';

import 'package:intl/intl.dart';

customPrint(String value) {
  DateTime now = DateTime.now();
  log("===>>> ${DateFormat("dd/MM/yyy").add_jms().format(now)} ===>>> $value");
}
