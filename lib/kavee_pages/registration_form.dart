import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:mood_shifting_assistent/my_home_page.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({ Key? key }) : super(key: key);

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {

  // text fields
  String fullName = '';
  String enrollmentNo = '';
  String email = '';
  String birthday = '';
  String gender = '';
  String department = '';
  String semester = '';
  String phoneNumber = '';

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

  // ---------- End validation functions --------------

  // ---------- Database function -----------

  // users collection reference
  final CollectionReference studentsCollection = FirebaseFirestore.instance.collection('students');

  Future sendStudentRegistrationDetails({String? fullName, String? enrollmentNo, String? email, String? birthday, String? gender, String? department, String? semester, String? phoneNumber}) async {

    return studentsCollection.doc().set({
      'fullName': fullName,
      'enrollmentNo': enrollmentNo,
      'email': email,
      'birthday': birthday,
      'gender': gender,
      'department': department,
      'semester': semester,
      'phoneNumber': phoneNumber,
      'timeStamp': FieldValue.serverTimestamp(),
    });

  }

  // ---------- End Database function -----------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff56A46E),
        title: const Text(
          'Student Registration Form'
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'Full Name', 
                style: TextStyle(
                  fontSize: 16.0, 
                  color: Colors.grey
                  ),
                ),
              TextFormField(
                cursorColor: const Color(0xff77BF87),
                decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff77BF87))
                  ),
                  // hintText: 'Enter your Email'
                ),
                style: const TextStyle(
                  fontSize: 18
                ),
                // validation
                validator: (val) => val!.isEmpty ? 'Enter Full name' : null,
                onChanged: (val) {
                  setState(() {
                    fullName = val;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Enrollment No', 
                style: TextStyle(
                  fontSize: 16.0, 
                  color: Colors.grey
                  ),
                ),
              TextFormField(
                cursorColor: const Color(0xff77BF87),
                decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff77BF87))
                  ),
                  // hintText: 'Enter your Email'
                ),
                style: const TextStyle(
                  fontSize: 18
                ),
                // validation
                validator: (val) => val!.isEmpty ? 'Enter Full name' : null,
                onChanged: (val) {
                  setState(() {
                    enrollmentNo = val;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Email', 
                style: TextStyle(
                  fontSize: 16.0, 
                  color: Colors.grey
                  ),
                ),
              TextFormField(
                cursorColor: const Color(0xff77BF87),
                decoration: InputDecoration(
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff77BF87))
                  ),
                  errorText: emailErrorText
                  // hintText: 'Enter your Email'
                ),
                style: const TextStyle(
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
              const SizedBox(height: 16.0),
              const Text(
                'Birthday', 
                style: TextStyle(
                  fontSize: 16.0, 
                  color: Colors.grey
                  ),
                ),
              TextFormField(
                cursorColor: const Color(0xff77BF87),
                decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff77BF87))
                  ),
                  // hintText: 'Enter your Email'
                ),
                style: const TextStyle(
                  fontSize: 18
                ),
                // validation
                validator: (val) => val!.isEmpty ? 'Enter Full name' : null,
                onChanged: (val) {
                  setState(() {
                    birthday = val;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Gender', 
                style: TextStyle(
                  fontSize: 16.0, 
                  color: Colors.grey
                  ),
                ),
              TextFormField(
                cursorColor: const Color(0xff77BF87),
                decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff77BF87))
                  ),
                  // hintText: 'Enter your Email'
                ),
                style: const TextStyle(
                  fontSize: 18
                ),
                // validation
                validator: (val) => val!.isEmpty ? 'Enter Full name' : null,
                onChanged: (val) {
                  setState(() {
                    gender = val;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Department', 
                style: TextStyle(
                  fontSize: 16.0, 
                  color: Colors.grey
                  ),
                ),
              TextFormField(
                cursorColor: const Color(0xff77BF87),
                decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff77BF87))
                  ),
                  // hintText: 'Enter your Email'
                ),
                style: const TextStyle(
                  fontSize: 18
                ),
                // validation
                validator: (val) => val!.isEmpty ? 'Enter Full name' : null,
                onChanged: (val) {
                  setState(() {
                    department = val;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Semester', 
                style: TextStyle(
                  fontSize: 16.0, 
                  color: Colors.grey
                  ),
                ),
              TextFormField(
                cursorColor: const Color(0xff77BF87),
                decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff77BF87))
                  ),
                  // hintText: 'Enter your Email'
                ),
                style: const TextStyle(
                  fontSize: 18
                ),
                // validation
                validator: (val) => val!.isEmpty ? 'Enter Full name' : null,
                onChanged: (val) {
                  setState(() {
                    semester = val;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Phone Number', 
                style: TextStyle(
                  fontSize: 16.0, 
                  color: Colors.grey
                  ),
                ),
              TextFormField(
                cursorColor: const Color(0xff77BF87),
                decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff77BF87))
                  ),
                  // hintText: 'Enter your Email'
                ),
                style: const TextStyle(
                  fontSize: 18
                ),
                // validation
                validator: (val) => val!.isEmpty ? 'Enter Full name' : null,
                onChanged: (val) {
                  setState(() {
                    phoneNumber = val;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              const SizedBox(height: 32.0,),
              Center(
                child: ElevatedButton( 
                  child: const Text(
                    'REGISTER', 
                    style: TextStyle(
                      fontSize: 16.0, 
                      color: Colors.white
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xff56A46E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)
                    ),
                    padding: EdgeInsets.fromLTRB(66.0, 16.0, 66.0, 16.0),
                  ),
                  onPressed:(
                    emailErrorText == null
                  ) ? () async {

                    if(email.isEmpty || enrollmentNo.isEmpty || birthday.isEmpty || gender.isEmpty || department.isEmpty || semester.isEmpty) {
              
                      Fluttertoast.showToast(
                        msg: "Please fill all the required fields",
                        toastLength: Toast.LENGTH_SHORT,
                      );
              
                    } else {

                      sendStudentRegistrationDetails(
                        fullName: fullName,
                        enrollmentNo: enrollmentNo,
                        email: email,
                        birthday: birthday,
                        gender: gender,
                        department: department,
                        semester: semester,
                        phoneNumber: phoneNumber
                      ).whenComplete(() {

                        Fluttertoast.showToast(
                          msg: "Registration Complete!",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          fontSize: 16.0
                        );

                        // Navigator.pushAndRemoveUntil(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => NewHomePage()),
                        //   (Route<dynamic> route) => false,
                        // );

                      });
        
                    }
                  } : null,
                ),
              ),
              const SizedBox(height: 8.0,),
            ]
          ),
        ),
      ),
    );
  }
}