import 'package:fingerprintauthflutter/editprofilepage.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

class FbLogin extends StatefulWidget {
  @override
  _FbLoginState createState() => _FbLoginState();
}

class _FbLoginState extends State<FbLogin> {
  Map userProfile;
  bool _isLoggedIn = false;
  final facebookLogin = FacebookLogin();
  @override
  void initState() {
    super.initState();
  }

  _logout(){
    facebookLogin.logOut();
    setState(() {
      _isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
//    return Container(
//      child: RaisedButton(
//        onPressed: (){
//          login(facebookLogin);
//        },
//        child: Text('Login with facebook'),
//      ),
//    );

    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: _isLoggedIn
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
//                Image.network(userProfile["picture"]["data"]["url"], height: 50.0, width: 50.0,),
                Text(userProfile["name"], style: TextStyle(color: Colors.blue[900], fontSize: 28, fontWeight: FontWeight.bold),),
                SizedBox(height: 21),
                OutlineButton( child: Text("Proceed Further"), onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Edit_Profile()));
                },),
                SizedBox(height: 21),
                OutlineButton( child: Text("Logout"), onPressed: (){
                  _logout();
                },)
              ],
            )
                : Center(
              child: OutlineButton(
                child: Text("Login with Facebook"),
                onPressed: () async{
//                  login(facebookLogin, userProfile,  _isLoggedIn);

                  final facebookLoginResult = await facebookLogin.logIn(['email']);

                  print(facebookLoginResult.accessToken);
                  print(facebookLoginResult.accessToken.token);
                  print(facebookLoginResult.accessToken.expires);
                  print(facebookLoginResult.accessToken.permissions);
                  print(facebookLoginResult.accessToken.userId);
                  print(facebookLoginResult.accessToken.isValid());

                  print(facebookLoginResult.errorMessage);
                  print(facebookLoginResult.status);

                  final token = facebookLoginResult.accessToken.token;

                  /// for profile details also use the below code
                  final graphResponse = await http.get(
                      'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=$token');
                  userProfile = json.decode(graphResponse.body);
                  _isLoggedIn = true;
                  print(userProfile);
                  setState(() {
                    _isLoggedIn = true;
                  });

                },
              ),
            )),
      ),
    );

  }
}
//_logout(facebookLogin){
//  facebookLogin.logOut();
//  setState(() {
//    _isLoggedIn = false;
//  });
//}

void login(facebookLogin, userProfile,  _isLoggedIn) async {
//  final facebookLogin = FacebookLogin();
  final facebookLoginResult = await facebookLogin.logIn(['email']);

  print(facebookLoginResult.accessToken);
  print(facebookLoginResult.accessToken.token);
  print(facebookLoginResult.accessToken.expires);
  print(facebookLoginResult.accessToken.permissions);
  print(facebookLoginResult.accessToken.userId);
  print(facebookLoginResult.accessToken.isValid());

  print(facebookLoginResult.errorMessage);
  print(facebookLoginResult.status);

  final token = facebookLoginResult.accessToken.token;

  /// for profile details also use the below code
  final graphResponse = await http.get(
      'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=$token');
  userProfile = json.decode(graphResponse.body);
  _isLoggedIn = true;
  print(userProfile);

  /*
    from profile you will get the below params
    {
     "name": "Iiro Krankka",
     "first_name": "Iiro",
     "last_name": "Krankka",
     "email": "iiro.krankka\u0040gmail.com",
     "id": "<user id here>"
    }
   */
}