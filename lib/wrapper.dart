import 'package:flutter/material.dart';
import 'package:mood_shifting_assistent/auth/sign_up.dart';
import 'package:mood_shifting_assistent/models/uid.dart';
import 'package:mood_shifting_assistent/my_home_page.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // listening to streamProvider
    final user = Provider.of<UID?>(context);
    // print('User : ' + user.toString());

    // return either Home or Authentication page
    if(user == null) {
      return const SignUp();
    } else {
      return NewHomePage();
    }
  }
}