import 'package:flutter/material.dart';
import 'package:task_management/ui/screens/forget_password_verify_otp_screen.dart';
import 'package:task_management/ui/widgets/screen_background.dart';
class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(child: Padding(
        padding: EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          
              SizedBox(height: 150,),
              Text('Set Password ',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8,),
              Text('Password should be more than 6 letters and combination of numbers',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Password'
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Confirm Password'
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              FilledButton(
                  onPressed: () {
          
                  //  Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPasswordVerifyOtpScreen()));
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
        ),
      )),
    );
  }
}
