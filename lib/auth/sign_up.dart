import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mood_shifting_assistent/auth/log_in.dart';
import 'package:mood_shifting_assistent/my_home_page.dart';
import 'package:mood_shifting_assistent/services/auth.dart';
import 'package:mood_shifting_assistent/utils/route_trans_anim.dart';

import '../models/uid.dart';

class SignUp extends StatefulWidget {
  const SignUp({ Key? key }) : super(key: key);  

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  AuthService _authService = AuthService();

  // to identify the form
  final _formKey = GlobalKey<FormState>();

  // text fields
  String username = '';
  String name = '';
  String email = '';
  String password = '';
  String confirmPassword = '';

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

  String? get usernameErrorText {

    if (username.isNotEmpty && username.length < 4) {
      return 'Username must be at least 4 characterss';
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

  String? get confirmPSErrorText {

    if (confirmPassword.isNotEmpty && confirmPassword.length < 8) {
      return 'Password must be more than 8 characters';
    }

    if(confirmPassword.isNotEmpty && confirmPassword != password) {
      return 'Password does not match';
    }
    return null;
  }

  // ---------- End validation functions --------------

  @override
  Widget build(BuildContext context) {

    return Material(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
          child: SafeArea(
            child: Form(
                child: Stack(
                  children: [
                    //  Image.network(
                    //   'https://images4.alphacoders.com/687/687987.jpg'
                    //  ),
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
                                'Name', 
                                style: TextStyle(
                                  fontSize: 16.0, 
                                  color: Colors.grey
                                ),
                              ),
                              TextFormField(
                                // controller: _textController,
                                cursorColor:const Color(0xff77BF87),
                                decoration: InputDecoration(
                                  //hintText: 'Enter your Name'
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: const Color(0xff77BF87))
                                  ),
                                ),
                                style: TextStyle(
                                  fontSize: 18
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    name = val;
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
                              SizedBox(height: 16.0),
                              Text(
                                'Confirm Password', 
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
                                  errorText: confirmPSErrorText
                                ),
                                style: TextStyle(
                                  fontSize: 18
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    confirmPassword = val;
                                  });
                                },
                              ),
                              SizedBox(height: 24.0,),
                              Center(
                                child: ElevatedButton( 
                                  child: Text(
                                    'SIGN UP', 
                                    style: TextStyle(
                                      fontSize: 16.0, 
                                      color: Colors.white
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: const Color(0xff77BF87),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)
                                    ),
                                    padding: EdgeInsets.fromLTRB(66.0, 16.0, 66.0, 16.0),
                                  ),
                                  onPressed:(
                                    emailErrorText == null &&
                                    usernameErrorText == null &&
                                    passwordErrorText == null && 
                                    confirmPSErrorText == null
                                  ) ? () async {

                                    if(email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
              
                                      Fluttertoast.showToast(
                                        msg: "Please fill all the required fields",
                                        toastLength: Toast.LENGTH_SHORT,
                                      );
              
                                    } else {
          
                                      // registering a user with email and password
                                      dynamic result = await _authService.registerWithEmailAndPassword(name, email, password);
          
                                      if(result == null) {
          
                                          // show an error message
                                          Fluttertoast.showToast(
                                            msg: "Email or password is invalid!",
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.BOTTOM,
                                            fontSize: 16.0
                                          );
          
                                      } else {
          
                                        Fluttertoast.showToast(
                                          msg: "Registration Complete!",
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.BOTTOM,
                                          fontSize: 16.0
                                        );
          
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(builder: (context) => NewHomePage()),
                                          (Route<dynamic> route) => false,
                                        );
                                      }
                                    }
                                  } : null,
                                ),
                              ),
                              SizedBox(height: 16.0,),
                              Center(
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Already have an account? ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Login',
                                        style: TextStyle(
                                          color: const Color(0xff77BF87),
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline
                                        ),
                                        recognizer: TapGestureRecognizer()..onTap = (){
                                          Navigator.of(context).push(
                                            RouteTransAnim().createRoute(
                                              1.0, 0.0, 
                                              Login()
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
        ),
    );
  }
}