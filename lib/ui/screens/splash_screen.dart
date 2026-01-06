import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:task_management/providers/auth_provider.dart';
import 'package:task_management/ui/controller/auth_controller.dart';
import 'package:task_management/ui/screens/login_page.dart';
import 'package:task_management/ui/utils/asset_paths.dart';
import 'package:task_management/ui/widgets/screen_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _moveToNextScreen();
    });

  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(Duration(seconds: 3));
    // await AuthController.getUserData();
    // final bool isLoggedIn = await AuthController.isUserLoggeIn();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.loadUserData();

    if(authProvider.isLoggedIn){
      Navigator.pushReplacementNamed(context, '/main_nav');
    }else{
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }

  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(child: Center(child: SvgPicture.asset(AssetPaths.logoSVG, height: 120, color: Colors.green,))),
    );
  }
}
