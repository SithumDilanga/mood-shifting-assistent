import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mood_shifting_assistent/models/uid.dart';
import 'package:mood_shifting_assistent/my_home_page.dart';
import 'package:mood_shifting_assistent/screens/home_page.dart';
import 'package:mood_shifting_assistent/services/auth.dart';
import 'package:mood_shifting_assistent/wrapper.dart';
import 'package:provider/provider.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(
        providers: [
          StreamProvider<UID?>.value(
            initialData: null,
            value: AuthService().user, 
          ),
        ],
        child: Wrapper(),
      ) //HomePage() //const MyHomePage(title: 'Flutter Demo'),
    );
  }
}

