import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mood_shifting_assistent/auth/sign_up.dart';
import 'package:mood_shifting_assistent/screens/home_page.dart';
import 'package:mood_shifting_assistent/services/auth.dart';
import 'package:mood_shifting_assistent/utils/route_trans_anim.dart';
import 'package:provider/provider.dart';

import '../models/uid.dart';

class Login extends StatefulWidget {
  const Login({ Key? key }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {


  AuthService _authService = AuthService();

  // text fields
  String email = '';
  String password = '';

  // ---------- validation functions --------------

  String? get emailErrorText {

    bool isValid = EmailValidator.validate(email);

    if(email.isEmpty) {
      return null;
    }

    if (!isValid) {
      return 'Invalid email';
    }

    return null;
  }

  String? get passwordErrorText {
    // final text = _textController.value.text;
    if (password.isNotEmpty && password.length < 8) {
      return 'Password must be more than 8 characters';
    }
    return null;
  }

  // ---------- End validation functions --------------

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child:  SafeArea(
          child: Form(
              child: Stack(
                children: [
                  // Image.network(
                  //  'https://images4.alphacoders.com/687/687987.jpg'
                  // ),
                  Image.asset(
                    'assets/images/auth-background-image2.png',
                    // height: 300,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 200.0, 16.0, 0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Email', 
                              style: TextStyle(
                                fontSize: 16.0, 
                                color: Colors.grey
                                ),
                              ),
                            TextFormField(
                              cursorColor: const Color(0xff77BF87),
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: const Color(0xff77BF87))
                                ),
                                errorText: emailErrorText
                                // hintText: 'Enter your Email'
                              ),
                              style: TextStyle(
                                fontSize: 18
                              ),
                              // validation
                              validator: (val) => val!.isEmpty ? 'Enter an Email' : null,
                              onChanged: (val) {
                                setState(() {
                                  email = val;
                                });
                              },
                            ),
                            SizedBox(height: 16.0),
                            Text(
                              'Password', 
                              style: TextStyle(
                                fontSize: 16.0, 
                                color: Colors.grey
                                ),
                              ),
                            TextFormField(
                              obscureText: true,
                              cursorColor: const Color(0xff77BF87),
                              decoration: InputDecoration(
                                //hintText: 'Enter your Password'
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: const Color(0xff77BF87))
                                ),
                                errorText: passwordErrorText
                              ),
                              style: TextStyle(
                                fontSize: 18
                              ),
                              // validation
                              // validator: (val) => val!.length < 6 ? 'Enter password 6+ characters long' : null,
                              onChanged: (val) {
                                setState(() {
                                  password = val;
                                });
                              },
                            ),
                            SizedBox(height: 48.0,),
                            Center(
                              child: RaisedButton(
                                child: Text(
                                  'LOGIN', 
                                  style: TextStyle(
                                    fontSize: 16.0, 
                                    color: Colors.white
                                  ),
                                ),
                                color: const Color(0xff77BF87),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)
                                ),
                                padding: EdgeInsets.fromLTRB(66.0, 16.0, 66.0, 16.0),
                                onPressed:(
                                  emailErrorText == null &&
                                  passwordErrorText == null
                                ) ? () async {

                                  if(email.isEmpty || password.isEmpty) {
        
                                    Fluttertoast.showToast(
                                      msg: "Please fill all the required fields",
                                      toastLength: Toast.LENGTH_SHORT,
                                    );
        
                                  } else {
        
                                    // logging a user with email and password
                                    dynamic result = await _authService.signInWithEmailAndPassword(email, password);
        
                                      if(result != null) {
        
                                        Fluttertoast.showToast(
                                          msg: "Login Success!",
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.BOTTOM,
                                          fontSize: 16.0
                                        );
        
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(builder: (context) =>     HomePage2()
                                          ),
                                          (Route<dynamic> route) => false,
                                        );
                                      }
                                  }
        
                                } : null,
                              ),
                            ),
                            const SizedBox(height: 16.0,),
                              Center(
                                child: RichText(
                                  text: TextSpan(
                                    text: "Don't have an account ? ",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Sign Up',
                                        style: const TextStyle(
                                          color: Color(0xff77BF87),
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                        ),
                                        recognizer: TapGestureRecognizer()..onTap = (){
                                          Navigator.of(context).push(
                                            RouteTransAnim().createRoute(
                                              1.0, 0.0, 
                                              SignUp()
                                            )
                                          );
                                        }
                                      )
                                    ]
                                  ), 
                                ),
                              ),
                          ]
                        )
                      )  
                    )
                  )
                ],
              )
            ),
        ),
        ),
      );
  }
}