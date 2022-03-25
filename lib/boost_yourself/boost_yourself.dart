import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mood_shifting_assistent/boost_yourself/prev_schedules.dart';
import 'package:mood_shifting_assistent/boost_yourself/shared_pref.dart';


class BoostYourself extends StatefulWidget {
  @override
  _BoostYourselfState createState() => _BoostYourselfState();
}

class _BoostYourselfState extends State<BoostYourself> with TickerProviderStateMixin{

  late AnimationController _animTextShowupController;
  late AnimationController _animRectFadeController;
  late Animation<Offset> _animationOffset;

  final qutoteTextController = TextEditingController();

  // shared preferences 
  List<String> quoteList = [];
  List<String> dateTimeList = [];

  double? _height;
  double? _width;

  String? _setTime, _setDate;

  String? _hour, _minute, _time;

  String? dateTime;

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  String date_time = '2021-4-29 10:35:00';

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();


  // ----- Schedule Notifications -----
  Future<void> scheduleNotification(String date_time) async {
    // var scheduledNotificationDateTime = DateTime.now().add(Duration(seconds: 8));
    
    var scheduledNotificationDateTime = DateTime.parse(date_time.toString());
    
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel id',
      'channel name',
      // 'channel description',
      icon: 'my_icon', //'flutter_devs'
      styleInformation: BigTextStyleInformation(''), //shows more text length
      // largeIcon: DrawableResourceAndroidBitmap('my_icon'),
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
      0,
      'Boost Yourself',
      qutoteTextController.text,
      scheduledNotificationDateTime,
      platformChannelSpecifics);
  }
  // ----- End Schedule Notifications -----

  // ---- Select Date -----
  Future<Null> _selectDate(BuildContext context) async {

    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });

      print('Date : ' + picked.toString());
  }
  // ---- End Select Date -----

  // ---- Select Time -----
  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour! + ' : ' + _minute!;
        _timeController.text = _time!;
        _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });

      print('Time : ' + picked.toString());
  }
  // ---- End Select Time -----

  // ---- when notification clicked -----
  void onSelectNotification(String? payload) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return BoostYourself();
    }));
  }
  // ---- End when notification clicked -----

  @override
  void initState() {
    _dateController.text = DateFormat.yMd().format(DateTime.now());

    _timeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();


    var initializationSettingsAndroid =
      AndroidInitializationSettings('my_icon');
    var initializationSettingsIOs = IOSInitializationSettings();

    var initSetttings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOs);

    flutterLocalNotificationsPlugin.initialize(initSetttings, 
      onSelectNotification: onSelectNotification
    );

    // ----- Animations -------
    _animTextShowupController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animRectFadeController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    final curve = CurvedAnimation(
      curve: Curves.decelerate,
      parent: _animTextShowupController,
    );

    _animationOffset = Tween<Offset>(
      begin: const Offset(0.0, 0.35),
      end: Offset.zero,
    ).animate(curve);

    _animTextShowupController.forward();
    _animRectFadeController.repeat(reverse: true);
    // ----- End Animations -------

    // getting shared preferences
    quoteList = SharedPref.getQuoteList() ?? [];
    dateTimeList = SharedPref.getDateTimeList() ?? [];

    super.initState();
  }

  @override
  void dispose() {
    _animTextShowupController.dispose();
    _animRectFadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;

    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    dateTime = DateFormat.yMd().format(DateTime.now());

    return Material(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text(
        //     'Boost Yourself',
        //     style: TextStyle(
        //       fontSize: 20,
        //     ),
        //   ),
        //   backgroundColor: Colors.blueGrey[700],
        // ),
        body: 
        Container(
          height: height,
            decoration: BoxDecoration(
              // image: DecorationImage(
              //   image: AssetImage('assets/images/background.jpg'),
              //   fit: BoxFit.cover
              // )
            ),
          child: Stack(
           children: <Widget>[
             Padding(    // Rectangle 1
               padding: const EdgeInsets.fromLTRB(0.0, 0.0, 24.0, 0.0),
               child: ClipPath(
                 clipper: TriangleClipper(),
                 child: Container(
                   height: 200,
                   width: 200,
                   color: Colors.blueGrey[700],
                 ),
               ),
             ),
             FadeTransition(
               opacity: _animRectFadeController,
               child: Padding(    // Rectangle 2
                 padding: const EdgeInsets.fromLTRB(108.0, 0.0, 0.0, 0.0),
                 child: RotatedBox(
                   quarterTurns: 2,
                   child: ClipPath(
                     clipper: TriangleClipper(),
                     child: Container(
                       height: 200,
                       width: 200,
                       color: Colors.blueGrey[700],
                     ),
                   ),
                 ),
               ),
             ),
             FadeTransition(
               opacity: _animRectFadeController,
               child: Padding(        // Rectangle 3
                 padding: const EdgeInsets.fromLTRB(220, 0.0, 0.0, 0.0),
                 child: ClipPath(
                   clipper: TriangleClipper(),
                   child: Container(
                     height: 100,
                     width: 100,
                     color: Colors.blueGrey[700],
                   ),
                 ),
               ),
             ),
             SingleChildScrollView(
               child: Column(                // Main Column
                 crossAxisAlignment: CrossAxisAlignment.stretch,
                 children: <Widget>[
                   Padding(
                     padding: const EdgeInsets.only(left: 30.0, top: 24.0),
                     child: Text(
                       'Type the quote you want',
                       style: TextStyle(
                         fontSize: 18,
                         color: Colors.white,
                         fontWeight: FontWeight.bold
                       ),
                     ),
                   ),
                   FadeTransition(
                     opacity: _animTextShowupController,
                     child: Padding(
                       padding: const EdgeInsets.only(top: 12.0, left: 30.0, right: 30.0,),
                       child: Material(
                         elevation: 5,
                         borderRadius: BorderRadius.circular(5),
                         child: TextFormField(    // Quote Text Form Field
                           controller: qutoteTextController,
                           cursorColor: Colors.black,
                           cursorHeight: 32,
                           decoration: InputDecoration(
                            //  isDense: true,
                             filled: true,
                             fillColor: Colors.white,
                             hintText: 'Your Quote Here...',
                             border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(5),
                               borderSide: BorderSide.none
                             ),
                             hintStyle: TextStyle(
                               fontSize: 24
                             ),
                             focusedBorder: OutlineInputBorder(
                               borderSide: BorderSide(color: Colors.white),
                             )
                           ),
                           style: TextStyle(
                             fontSize: 24,
                             fontWeight: FontWeight.bold
                           ),
                         ),
                       ),
                     ),
                   ),
                   SizedBox(height: 32.0),
                   Row(      // Choose Date and Time
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                     children: <Widget>[
                       Column(       // Choose Date
                       crossAxisAlignment: CrossAxisAlignment.start,
                         children: <Widget>[
                           Text(
                             'Choose Date',
                             textAlign: TextAlign.left,
                             style: TextStyle(
                               fontSize: 16,
                               color: Colors.white,
                               fontWeight: FontWeight.bold
                             ),
                           ),
                           SizedBox(height: 8.0),
                           InkWell(
                            onTap: () {
                              _selectDate(context);
                            },
                            child: Container(
                              width: _width! / 2.5,
                              height: _height! / 12,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.grey[200]!.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(5)
                              ),
                              child: TextFormField(
                                style: TextStyle(fontSize: 24),
                                textAlign: TextAlign.center,
                                enabled: false,
                                keyboardType: TextInputType.text,
                                controller: _dateController,
                                onSaved: (String? val) async {
                                  _setDate = val;
                                  // print('Date : ' + _setDate.toString());
                                },
                                decoration: InputDecoration(
                                    disabledBorder:
                                        UnderlineInputBorder(borderSide: BorderSide.none),
                                    // labelText: 'Time',
                                    contentPadding: EdgeInsets.only(top: 0.0)),
                              ),
                            ),
                          ),
                         ]
                       ),
                      //  SizedBox(width: 32.0),
                       Column(      // Choose Time
                       crossAxisAlignment: CrossAxisAlignment.start,
                         children: <Widget>[
                           Text(
                             'Choose Time',
                             textAlign: TextAlign.left,
                             style: TextStyle(
                               fontSize: 16,
                               color: Colors.white,
                               fontWeight: FontWeight.bold
                             ),
                           ),
                           SizedBox(height: 8.0),
                           InkWell(
                            onTap: () {
                              _selectTime(context);
                            },
                            child: Container(
                              width: _width! / 2.5,
                              height: _height! / 12,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.grey[200]!.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(5)
                              ),
                              child: TextFormField(
                                style: TextStyle(fontSize: 24),
                                textAlign: TextAlign.center,
                                onSaved: (String? val) async {
                                  _setTime = val;
                                  // print('Date : ' + _setTime.toString());
                                },
                                enabled: false,
                                keyboardType: TextInputType.text,
                                controller: _timeController,
                                decoration: InputDecoration(
                                    disabledBorder:
                                        UnderlineInputBorder(borderSide: BorderSide.none),
                                    // labelText: 'Time',
                                    contentPadding: EdgeInsets.all(5)),
                              ),
                            ),
                          ),
                         ]
                       )
                     ],
                   ),
                   SizedBox(height: 32.0),
                   Padding(                 // Schedule button
                     padding: const EdgeInsets.only(left: 95.0, right: 95.0),
                     child: ElevatedButton(    
                       onPressed: () async {

                         print('selectedDate ' + selectedDate.toString());
                         print('selectedTime ' + selectedTime.format(context));
     
                         setState(() {
                           date_time =  
                           selectedDate.year.toString() + '-' +
                           selectedDate.month.toString().padLeft(2,'0') + '-' +
                           selectedDate.day.toString().padLeft(2,'0') + ' ' + 
                           selectedTime.hour.toString().padLeft(2,'0') + ':' + 
                           selectedTime.minute.toString().padLeft(2,'0') + ':00';
                         });
     
                         print('dt ' + date_time.toString());
     
                         scheduleNotification(date_time);

                         Fluttertoast.showToast(
                           msg: 'Quote Scheduled Successfully!',
                           toastLength: Toast.LENGTH_SHORT
                          );

                          quoteList.add(qutoteTextController.text);
                          print(quoteList);

                          dateTimeList.add(date_time);
                          print(dateTimeList);

                          // ---- prevent list taking too much elements ----
                          if(quoteList.length == 5) {
                            quoteList.removeRange(0, 3);
                          }

                          if(dateTimeList.length == 5) {
                            dateTimeList.removeRange(0, 3);
                          }
                          // ---- End prevent list taking too much elements ----

                          // setting shared preferences
                          await SharedPref.setQuoteList(quoteList);
                          await SharedPref.setDateTimeList(dateTimeList);

                       },
                       style: ButtonStyle(
                         backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                         shape: MaterialStateProperty.all(
                           RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)
                         )
                        ),
                        padding: MaterialStateProperty.all(
                          EdgeInsets.only(top: 12.0, bottom: 12.0)
                        ),
                        elevation: MaterialStateProperty.all(3.8)
                       ), 
                       child: Text(
                         'Schedule',
                         style: TextStyle(
                           fontSize: 20.0,
                           color: Colors.blueGrey[700],
                           fontWeight: FontWeight.bold
                         )
                       )
                      ),
                   ),
                   SizedBox(height: 16.0),
                   Padding(
                     padding: const EdgeInsets.only(left: 24.0),
                     child: Text(
                       'Previous Schedules',
                       style: TextStyle(
                         fontSize: 16.0,
                         color: Colors.white,
                         fontWeight: FontWeight.bold
                       ),
                     ),
                   ),
                   SizedBox(height: 4.0),                    
                   PreviousSchedules(quoteList: quoteList, dateTimeList: dateTimeList,),
                   SizedBox(height: 32.0),
                   FadeTransition(
                     opacity: _animTextShowupController,
                     child: SlideTransition(
                       position: _animationOffset,
                       child: Padding(          // 'What is..' Card view
                         padding: const EdgeInsets.only(left: 48.0, right: 48.0),
                         child: Container(
                           decoration: BoxDecoration(
                             color: Colors.white.withOpacity(0.9),
                             borderRadius: BorderRadius.circular(5)
                           ),
                           child: Padding(
                             padding: const EdgeInsets.all(16.0),
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.stretch,
                               children: <Widget>[
                                 RichText(
                                   textAlign: TextAlign.left,
                                   text: TextSpan(
                                     text: 'What is ',
                                     style: TextStyle(
                                       fontSize: 18,
                                       color: Colors.black,
                                     ),
                                     children: [
                                       TextSpan(
                                         text: 'Boost Yourself ?',
                                         style: TextStyle(
                                           fontWeight: FontWeight.bold
                                         )
                                       )
                                     ]
                                   )
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    'You can set your own custom notification for a given date and time. Simply Type the Quote you want to notify and set a date and time. This will help you to keep your motivation straight with your favourite quotes. ',
                                    style: TextStyle(
                                       fontSize: 16,
                                       color: Colors.black,
                                     )
                                  )
                               ],
                             ),
                           )
                            ),
                         ),
                     ),
                   ),
                   SizedBox(height: 8.0)
                 ]
               ),
             )
           ]
              ),
        ),
      ),
    );
  }
}