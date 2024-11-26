import 'package:e_com_app/bindings/general_bindings.dart';
import 'package:e_com_app/routes/app_routes.dart';
import 'package:e_com_app/util/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'util/constants/colors.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: EAppTheme.lightTheme,
      darkTheme: EAppTheme.darkTheme,
      initialBinding: GeneralBindings(),
      getPages: AppRoutes.pages,
      home: const Scaffold(backgroundColor: EColors.primary, body: Center(child: CircularProgressIndicator(color: Colors.white))),
    );
  }
}