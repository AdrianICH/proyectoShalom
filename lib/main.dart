import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:principal_shalom/controllers/controladorGeneral.dart';
import 'ui/loginPage.dart';

void main() {
  Get.put(ControlPersonas());
  runApp(const Login());
}
