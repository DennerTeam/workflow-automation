import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnack(String title, String message) {
  Get.showSnackbar(GetSnackBar(
    title: title,
    message: message,
  ));
}
