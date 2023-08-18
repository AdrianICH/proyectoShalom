import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:principal_shalom/controllers/controlador_general.dart';
import 'ui/login/login_page.dart';

void main() {
  Get.put(ControlUsuarios());
  runApp(const Login());
}
