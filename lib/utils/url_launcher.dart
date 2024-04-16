import 'package:trend_radar/utils/snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

urlLauncher({required String? url}) async {
  try {
    if (url != null) {
      final Uri uri = Uri.parse(url);
      if (await launchUrl(uri)) {
      } else {
        showToast(msg: "Could not launch $url");
      }
    } else {
      showToast(msg: "Url Not Found");
    }
  } catch (e) {
    showToast(msg: "Could not launch $url");
  }
}
