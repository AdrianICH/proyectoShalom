import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:principal_shalom/controllers/controlador_general.dart';
import 'ui/login_page.dart';

void main() {
  Get.put(ControlPersonas());
  runApp(const Login());
}
