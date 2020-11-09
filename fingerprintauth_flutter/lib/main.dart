import 'package:fingerprintauthflutter/editprofilepage.dart';
import 'package:fingerprintauthflutter/fingerprintauth.dart';
import 'package:fingerprintauthflutter/google_auth.dart';
import 'package:flutter/material.dart';

import 'User_Profile_page.dart';
import 'loginwith_facebook.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text('Fingerprint Auth')
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(child: Image(image: AssetImage('assets/facebook.jpeg')), onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => FbLogin()));
            }),
            GestureDetector(child: Image(image: AssetImage('assets/google.jpg'), width: 335, height: 215), onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Google_SignIn()));
            }),
            SizedBox(height: 45),
            ButtonTheme(
              height: 65,
              minWidth: 330.0,
              child: RaisedButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Fingerprint_Auth()));
              },

                  child: Text('login with fingerprint', style: TextStyle(color: Colors.white, fontSize: 22))),
            )
          ],
        ),
      ),
    );
  }
}

