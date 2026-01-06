import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management/data/model/user_model.dart';
import 'package:task_management/data/services/api_caller.dart';
import 'package:task_management/data/utils/urls.dart';
import 'package:task_management/providers/auth_provider.dart';
import 'package:task_management/ui/controller/auth_controller.dart';
import 'package:task_management/ui/screens/forget_password_email_verify.dart';
import 'package:task_management/ui/screens/main_nav_bar_holder_screen.dart';
import 'package:task_management/ui/screens/sign_up_screen.dart';
import 'package:task_management/ui/widgets/screen_background.dart';

import '../../providers/network_provider.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
 final TextEditingController _emailController = TextEditingController();
 final  TextEditingController _passwordController = TextEditingController();
 final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

 bool _signInProgress = false;


  @override
  Widget build(BuildContext context) {
    void _onTapSignUp(){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
    }

    void _onTabForgetPassword(){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPasswordEmailVerify()));
    }
    
    return Scaffold(
      body: ScreenBackground(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 150,),
                    Text('Get Started With ',
                    style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 20,),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'Email',
                      ),
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Please enter your email';
                        }
                        final emailRegExp = RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        );
                        if (!emailRegExp.hasMatch(value)) {
                          return 'Please entry valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20,),
                    TextFormField(
                      obscureText: true,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: 'Password',
                      ),
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Enter your password';
                        }
                        if(value.length < 6){
                          return 'Enter password more than 6 Character';
                        }
                      },
                    ),
                    const SizedBox(height: 20,),

                    FilledButton(onPressed: (){
                      if(_formKey.currentState!.validate()){
                        _signIn();

                      }

                    }, child: Icon(Icons.arrow_circle_right_outlined, size: 30,)),
                    Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 45,),
                          TextButton(onPressed: _onTabForgetPassword, child: Text('Forget Password ? ')),
                          RichText(text: TextSpan(
                            text: "Don't have an Account ?",
                            children: [
                              TextSpan(
                                  text: ' Sign Up',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold
                                  ),
                                recognizer: TapGestureRecognizer()..onTap =_onTapSignUp
                              ),

                            ],
                            style: TextStyle(
                                color: Colors.black
                            ),
                          ),
                          )
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
          )
      ),
    );
  }


  _clearTextField(){
    _emailController.clear();
    _passwordController.clear();
  }

 Future<void> _signIn() async {
   final networkProvider = Provider.of<NetworkProvider>(context, listen: false);
   final authProvider = Provider.of<AuthProvider>(context,listen: false);

   final result = await networkProvider.login(
       email: _emailController.text.trim(),
       password: _passwordController.text
   );

   if(result != null){
     await authProvider.saveUserData(result['user'], result['token']);
     ApiCaller.accessToken = result['token'];
     _clearTextField();
     ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
         content: Text('Login Success', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
         backgroundColor: Colors.green,
         duration: Duration(seconds: 5),
       ),
     );
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainNavBarHolderScreen()));
   }
   else{
     //print(response.responseData['data']);
     ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
         content: Text(networkProvider.errorMessage ?? 'Login Failed..', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
         backgroundColor: Colors.red,
         duration: Duration(seconds: 5),
       ),
     );
   }
 }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

}
