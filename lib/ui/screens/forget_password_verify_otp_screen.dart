import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_management/ui/screens/forget_password_verify_otp_screen.dart';
import 'package:task_management/ui/screens/reset_password_screen.dart';
import 'package:task_management/ui/widgets/screen_background.dart';
class ForgetPasswordVerifyOtpScreen extends StatelessWidget {
  const ForgetPasswordVerifyOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(child: Padding(
        padding: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 150,),
            Text('PIN Verification',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8,),
            Text('A 6-digit OTP sent to your email address',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey
              ),
            ),
            SizedBox(height: 15,),
            PinCodeTextField(
              length: 6,
              obscureText: false,
              animationType: AnimationType.fade,
              keyboardType: TextInputType.number,
              pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(7),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: Colors.white,
                  inactiveColor: Colors.grey.shade300,
                  selectedColor: Colors.green
              ),
              animationDuration: Duration(milliseconds: 300),
              backgroundColor: Colors.transparent,
              appContext: context,
            ),
            const SizedBox(
              height: 16,
            ),
            FilledButton(
                onPressed: () {

                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ResetPasswordScreen()));
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
                          )
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
