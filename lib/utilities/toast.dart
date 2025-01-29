import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class Toast {
  static void succesToast(String title, String description) {
    toastification.show(
      style: ToastificationStyle.flat,
      type: ToastificationType.success,
      title: Text(title),
      description: Text(description),
      autoCloseDuration: Duration(seconds: 6),
    );
  }

  static void warningToast(String title, String description) {
    toastification.show(
      style: ToastificationStyle.flat,
      type: ToastificationType.warning,
      title: Text(title),
      description: Text(description),
      autoCloseDuration: Duration(seconds: 6),
    );
  }
}
