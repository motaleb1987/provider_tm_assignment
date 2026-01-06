import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_management/ui/screens/forget_password_verify_otp_screen.dart';
import 'package:task_management/ui/screens/login_page.dart';
import 'package:task_management/ui/widgets/screen_background.dart';
class ForgetPasswordEmailVerify extends StatelessWidget {
  const ForgetPasswordEmailVerify({super.key});

  @override
  Widget build(BuildContext context) {

    void _onTapSignIn(){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
    }

    return Scaffold(
      body: ScreenBackground(child: Padding(
        padding: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 150,),
            Text('Your Email Address ',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8,),
            Text('A 6-digit verification PIN will be sent to your email address.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.grey
            ),
            ),
            TextFormField(
              decoration: InputDecoration(
                  hintText: 'Email'
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            FilledButton(
                onPressed: () {

                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPasswordVerifyOtpScreen()));
                },
                child: Icon(Icons.arrow_circle_right_outlined, size: 30,)),
            const SizedBox(
              height: 35,
            ),

            Center(
              child: Column(
                children: [
                  //const SizedBox(height: 45,),
                 // TextButton(onPressed: (){}, child: Text('Forget Password ? ')),
                  RichText(text: TextSpan(
                    text: "Already have an account?",
                    children: [
                      TextSpan(
                          text: ' Sign in',
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold
                          ),
                        recognizer: TapGestureRecognizer()..onTap = _onTapSignIn
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
      )),
    );
  }
}
