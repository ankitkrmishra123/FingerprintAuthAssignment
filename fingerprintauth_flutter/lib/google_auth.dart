import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'editprofilepage.dart';


GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
//      'https://www.googleapis.com/auth/contacts.readonly',
    // you can add extras if you require
  ],
);

class Google_SignIn extends StatefulWidget {
  @override
  _Google_SignInState createState() => _Google_SignInState();
}

class _Google_SignInState extends State<Google_SignIn> {

  GoogleSignInAccount _currentUser;

  @override
  void initState() {
    super.initState();
//    login();

    // TODO: implement initState
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account){
      setState(() {
        _currentUser = account;
      });
    });
    _googleSignIn.signInSilently();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Sign in Demo'),
      ),
      body: Center(child: _buildBody(_currentUser, context)),
    );
  }
}

Widget _buildBody(_currentUser, context) {
  if (_currentUser != null) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        ListTile(
          leading: GoogleUserCircleAvatar(
            identity: _currentUser,
          ),
          title: Text(_currentUser.displayName ?? ''),
          subtitle: Text(_currentUser.email ?? ''),
        ),
        RaisedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Edit_Profile()));
          },
          child: Text('Proceed further'),
        ),
        SizedBox(height: 43),
        RaisedButton(
          onPressed: _handleSignOut,
          child: Text('Sign in with another account'),
        )
      ],
    );
  }
  else{
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Text('You are not signed in..'),
        RaisedButton(
          onPressed: _handleSignIn,
          child: Text('SIGN IN'),
        )
      ],
    );
  }
}

Future<void> _handleSignIn() async{
  try{
    await _googleSignIn.signIn();
  }catch(error){
    print(error);
  }
}

Future<void> _handleSignOut() async{
  _googleSignIn.disconnect();
}


void login() async {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
//      'https://www.googleapis.com/auth/contacts.readonly',
      // you can add extras if you require
    ],
  );

  _googleSignIn.signIn().then((GoogleSignInAccount acc) async {
    GoogleSignInAuthentication auth = await acc.authentication;
    print(acc.id);
    print(acc.email);
    print(acc.displayName);
    print(acc.photoUrl);

    acc.authentication.then((GoogleSignInAuthentication auth) async {
      print(auth.idToken);
      print(auth.accessToken);
    });
  });
}