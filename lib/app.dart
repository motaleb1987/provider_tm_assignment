
import 'package:flutter/material.dart';
import 'package:task_management/ui/screens/login_page.dart';
import 'package:task_management/ui/screens/main_nav_bar_holder_screen.dart';
import 'package:task_management/ui/screens/new_task_screen.dart';
import 'package:task_management/ui/screens/sign_up_screen.dart';
import 'package:task_management/ui/screens/splash_screen.dart';
import 'package:task_management/ui/screens/update_profile_screen.dart';
class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});
  static GlobalKey <NavigatorState> navigator = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600
          )
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: Colors.green[400],
            fixedSize: Size.fromWidth(double.maxFinite),
            padding: EdgeInsets.symmetric(vertical: 7),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            )
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.white,
          filled: true,
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide.none
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none
          ),
        )
      ),
     // home: SplashScreen(),
      initialRoute: '/splash_screen',
      routes: {
        '/splash_screen': (context)=>SplashScreen(),
        '/login': (context)=>LoginPage(),
        '/sign_up': (context)=>SignUpScreen(),
        '/main_nav': (context)=>MainNavBarHolderScreen(),
        '/update_prof': (context)=>UpdateProfileScreen(),
        '/new_task': (context)=>NewTaskScreen(),
      },

    );
  }
}
