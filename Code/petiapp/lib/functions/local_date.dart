import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:time_ago_provider/time_ago_provider.dart' as timeago;

getLocalDate(String utc) {
  var dateFormat = DateFormat("dd-MM-yyyy hh:mm aa");
  var utcDate = dateFormat.format(DateTime.parse(utc));
  var localDate = dateFormat.parse(utcDate, true).toLocal().toString();
  final convertLocal = DateTime.parse(localDate).toLocal();
  return timeago
      .format(convertLocal, locale: '${Get.locale?.languageCode}_short')
      .toString();
}
