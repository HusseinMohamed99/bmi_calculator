import 'package:bmi_calculator/core/helpers/export_manager/export_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BmiCalculatorApp extends StatelessWidget {
  const BmiCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BmiCubit(),
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          SystemChrome.setPreferredOrientations(
            [
              DeviceOrientation.portraitUp,
              DeviceOrientation.portraitDown,
            ],
          );
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: const TextScaler.linear(1.0),
            ),
            child: MaterialApp(
              title: 'BMI Calculator',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                scaffoldBackgroundColor: ColorManager.backgroundColor,
                appBarTheme: AppBarTheme(
                  backgroundColor: ColorManager.backgroundColor,
                  centerTitle: true,
                  titleTextStyle: buildTextStyle(
                    context: context,
                    fontSize: 25,
                    letterSpacing: 6,
                  ),
                  systemOverlayStyle: SystemUiOverlayStyle(
                    systemNavigationBarColor: ColorManager.backgroundColor,
                  ),
                ),
              ),
              home: const BmiScreen(),
            ),
          );
        },
      ),
    );
  }
}
