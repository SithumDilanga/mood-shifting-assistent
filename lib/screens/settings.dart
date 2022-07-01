import 'package:flutter/material.dart';
import 'package:mood_shifting_assistent/admin/add_daily_quote.dart';
import 'package:mood_shifting_assistent/auth/log_in.dart';
import 'package:mood_shifting_assistent/services/auth.dart';
import 'package:mood_shifting_assistent/utils/route_trans_anim.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    AuthService _authService = AuthService();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF77BF87),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded
          ),
          onPressed: () {
            Navigator.pop(context);
          }, 
        ),
        title: Text(
          'Settings'
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView(
          children: [
            CustomeListTile(
              Icons.format_quote_rounded,
              'Add daily quote',
              () {
                Navigator.of(context).push(
                  RouteTransAnim().createRoute(
                    1.0, 0.0, 
                    AddDailyQuote()
                  )
                );
              }
            ),
            CustomeListTile(
              Icons.logout_rounded,
              'Logout',
              () {

                _authService.logOut().whenComplete(() {

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                    (Route<dynamic> route) => false,
                  );

                });

              }
            ),
          ],
        ),
      ),
    );
  }
}

class CustomeListTile extends StatelessWidget {

  final IconData icon;
  final String text;
  final void Function() onTap;

  CustomeListTile(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey))
      ),
      child: InkWell(
        splashColor: Colors.blue[100],
        borderRadius: BorderRadius.circular(3),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              Icon(
                icon, 
                size: 22, 
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 0),
                child: Text(
                  text, 
                  style: TextStyle(
                    fontSize: 18, 
                    color: Colors.black, 
                    // shadows: [Shadow(blurRadius: 7.0, color: Colors.blueGrey[200]!, offset: Offset(1.0, 1.0),)]
                  ),
                ),
              )
            ],
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}