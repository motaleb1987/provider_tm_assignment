import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management/data/services/api_caller.dart';
import 'package:task_management/data/utils/urls.dart';
import 'package:task_management/providers/network_provider.dart';
import 'package:task_management/ui/screens/forget_password_verify_otp_screen.dart';
import 'package:task_management/ui/screens/login_page.dart';
import 'package:task_management/ui/widgets/screen_background.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _signUpInProgress = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: EdgeInsets.all(25),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 130),
                    Text(
                      'Join With Us',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10),

                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(hintText: 'Email'),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
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
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _firstNameController,
                      decoration: InputDecoration(hintText: 'First Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your first name';
                        }
                        if (value.trim().length < 2) {
                          return 'Enter first name at least 2 character';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _lastNameController,
                      decoration: InputDecoration(hintText: 'Last Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your last name';
                        }
                        if (value.trim().length < 2) {
                          return 'Enter last name at least 2 character';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _mobileController,
                      decoration: InputDecoration(hintText: 'Mobile'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your Mobile number';
                        }
                        if (value.trim().length != 11) {
                          return 'Enter valid phone number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(hintText: 'Password'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your password';
                        }
                        if (value.length < 6) {
                          return 'Enter password more than 6 Character';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),

                    Visibility(
                      visible: !_signUpInProgress,
                      replacement: Center(child: CircularProgressIndicator()),
                      child: FilledButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _signUp();
                            //Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPasswordVerifyOtpScreen()));
                          }

                        },
                        child: Icon(Icons.arrow_circle_right_outlined, size: 30),
                      ),
                    ),
                    const SizedBox(height: 35),

                    Center(
                      child: Column(
                        children: [
                          //const SizedBox(height: 45,),
                          // TextButton(onPressed: (){}, child: Text('Forget Password ? ')),
                          RichText(
                            text: TextSpan(
                              text: "Already have an account?",
                              children: [
                                TextSpan(
                                  text: ' Sign in',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer: TapGestureRecognizer()..onTap = _onTapSignIn
                                ),
                              ],
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _clearTextField() {
    _emailController.clear();
    _firstNameController.clear();
    _lastNameController.clear();
    _mobileController.clear();
    _passwordController.clear();
  }

  Future<void> _signUp() async {
    final networkProvider = Provider.of<NetworkProvider>(context, listen: false);
    final result = networkProvider.register(
        email: _emailController.text.trim(),
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        mobile: _mobileController.text.trim(),
        password: _passwordController.text
    );
    if(result != null){
      _clearTextField();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sign up Success', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 5),
        ),
      );
    }
    else{
      //print(response.responseData['data']);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(networkProvider.errorMessage ?? 'Something Wrong..', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
        ),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onTapSignIn(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
  }

}
