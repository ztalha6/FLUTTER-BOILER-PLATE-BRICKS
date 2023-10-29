import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Utils {
  static final Utils _singleton = Utils._internal();

  factory Utils() {
    return _singleton;
  }

  Utils._internal();

  void clearKeyboardFocus() {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
  }

  bool isNotNull(dynamic object) {
    return object != null ? true : false;
  }

  String formatFileSize(int totalSizeInBytes) {
    final double totalSizeInKB = totalSizeInBytes / 1024;
    final double totalSizeInMB = totalSizeInKB / 1024;
    final double totalSizeInGB = totalSizeInMB / 1024;

    if (totalSizeInGB >= 1) {
      return '${totalSizeInGB.toStringAsFixed(2)} GB';
    } else if (totalSizeInMB >= 1) {
      return '${totalSizeInMB.toStringAsFixed(2)} MB';
    } else {
      return '${totalSizeInKB.toStringAsFixed(2)} KB';
    }
  }

  void clearKeyboardFocus() {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
  }

  bool isNotNull(dynamic object) {
    return object != null;
  }

  String convertServerTimeToLocalTime(
    String serverTime, {
    bool getDateOnly = false,
    bool getTimeOnly = false,
    bool getMonthWithName = false,
  }) {
    // Parse server time into DateTime object
    final DateTime serverDateTime = DateTime.parse(serverTime);
    // Get the offset between the server time zone and the local time zone
    final Duration offset =
        DateTime.now().timeZoneOffset - serverDateTime.timeZoneOffset;
    // Adjust the server time by the offset to get the local time
    final DateTime localDateTime = serverDateTime.add(offset);
    // Format the date and time using the intl package
    final String formattedDate = getMonthWithName
        ? DateFormat('d-MMM-yyyy').format(localDateTime)
        : DateFormat('d-MM-yyyy').format(localDateTime);
    final String formattedTime = DateFormat('hh:mm a').format(localDateTime);
    // Return the formatted local date and time
    return getDateOnly
        ? formattedDate
        : getTimeOnly
            ? formattedTime
            : '$formattedDate $formattedTime';
  }

  String formatDateToISO(
    DateTime date, {
    bool use24HrsTime = false,
    bool getDateOnly = false,
    bool getTimeOnly = false,
  }) {
    return use24HrsTime
        ? DateFormat('yyyy-MM-dd HH:mm:ss').format(date)
        : getDateOnly
            ? DateFormat('yyyy-MM-dd').format(date)
            : getTimeOnly
                ? DateFormat('hh:mm a').format(date)
                : DateFormat('yyyy-MM-dd hh:mm a').format(date);
  }

  String formatTimeOfDayTo24HrForAddMedicine(TimeOfDay time) {
    if (time.hour < 10 && time.minute < 10) {
      return "0${time.hour}:0${time.minute}:00";
    } else if (time.minute < 10) {
      return "${time.hour}:0${time.minute}:00";
    } else if (time.hour < 10) {
      return "0${time.hour}:${time.minute}:00";
    } else {
      return "${time.hour}:${time.minute}:00";
    }
  }

  String formatTimeOfDayTo24Hr(TimeOfDay time) {
    return "${time.hour}:${time.minute}:00";
  }

  String formatTimeOfDayTo12Hr(TimeOfDay tod) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  String formatDateTimeTo12Hr(DateTime tod) {
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(tod);
  }

  String extractFileName(String path) {
    final Uri uri = Uri.parse(path);
    final String fileName = uri.pathSegments.last;
    return fileName;
  }

  String extractFileExtension(String path) {
    final Uri uri = Uri.parse(path);
    final String fileName = uri.pathSegments.last;
    final String extension = fileName.split('.').last;
    return extension;
  }

  String getCurrentUTCTimezone({bool withUTCSign = false}) {
    final now = DateTime.now();
    final timeZone = now.timeZoneOffset;
    final timeZoneSign = timeZone.isNegative ? '-' : '+';
    final timeZoneHours = timeZone.inHours.abs();
    final timeZoneMinutes = timeZone.inMinutes.remainder(60).abs();
    return withUTCSign
        ? 'UTC$timeZoneSign${timeZoneHours.toString().padLeft(2, '0')}:${timeZoneMinutes.toString().padLeft(2, '0')}'
        : '$timeZoneSign${timeZoneHours.toString().padLeft(2, '0')}:${timeZoneMinutes.toString().padLeft(2, '0')}';
  }

  static String makeChatId(String myID, String selectedUserID) {
    String chatID;
    if (myID.hashCode > selectedUserID.hashCode) {
      chatID = '$selectedUserID-$myID';
    } else {
      chatID = '$myID-$selectedUserID';
    }
    return chatID;
  }

  static String readTimestamp(int timestamp) {
    final now = DateTime.now();
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      if (diff.inHours > 0) {
        time = '${diff.inHours}h ago';
      } else if (diff.inMinutes > 0) {
        time = '${diff.inMinutes}m ago';
      } else if (diff.inSeconds > 0) {
        time = 'now';
      } else if (diff.inMilliseconds > 0) {
        time = 'now';
      } else if (diff.inMicroseconds > 0) {
        time = 'now';
      } else {
        time = 'now';
      }
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      time = '${diff.inDays}d ago';
    } else if (diff.inDays > 6) {
      time = '${(diff.inDays / 7).floor()}w ago';
    } else if (diff.inDays > 29) {
      time = '${(diff.inDays / 30).floor()}m ago';
    } else if (diff.inDays > 365) {
      time = '${date.month}-${date.day}-${date.year}';
    }
    return time;
  }
}
