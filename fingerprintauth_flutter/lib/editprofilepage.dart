import 'package:fingerprintauthflutter/User_Profile_page.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart' as validator;
import 'model.dart';

class Edit_Profile extends StatefulWidget {
  @override
  _Edit_ProfileState createState() => _Edit_ProfileState();
}

class _Edit_ProfileState extends State<Edit_Profile> {
  final _formKey = GlobalKey<FormState>();
  Model model = Model();

  @override
  Widget build(BuildContext context) {
    final halfMediaWidth = MediaQuery.of(context).size.width / 2.0;

    return Form(
      key: _formKey,
      child: Material(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topCenter,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topCenter,
                      width: halfMediaWidth,
                      child: MyTextFormField(
                        hintText: 'First Name',
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Enter your first name';
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          model.firstName = value;
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      width: halfMediaWidth,
                      child: MyTextFormField(
                        hintText: 'Last Name',
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Enter your last name';
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          model.lastName = value;
                        },
                      ),
                    )
                  ],
                ),
              ),
              MyTextFormField(
                hintText: 'Email',
                isEmail: true,
                validator: (String value) {
                  if (!validator.isEmail(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                onSaved: (String value) {
                  model.email = value;
                },
              ),
              MyTextFormField(
                hintText: 'Short Bio',
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter a short bio of yours';
                  }
                  return null;
                },
                onSaved: (String value) {
                  model.shortbio = value;
                },
              ),
              MyTextFormField(
                hintText: 'Password',
                isPassword: true,
                validator: (String value) {
                  if (value.length < 7) {
                    return 'Password should be minimum 7 characters';
                  }

                  _formKey.currentState.save();

                  return null;
                },
                onSaved: (String value) {
                  model.password = value;
                },
              ),
              MyTextFormField(
                hintText: 'Confirm Password',
                isPassword: true,
                validator: (String value) {
                  if (value.length < 7) {
                    return 'Password should be minimum 7 characters';
                  } else if (model.password != null && value != model.password) {
                    print(value);
                    print(model.password);
                    return 'Password not matched';
                  }

                  return null;
                },
              ),
              RaisedButton(
                color: Colors.blueAccent,
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserProfilePage(model: this.model)));
                  }
                },
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}

class MyTextFormField extends StatelessWidget {
  final String hintText;
  final Function validator;
  final Function onSaved;
  final bool isPassword;
  final bool isEmail;

  MyTextFormField({
    this.hintText,
    this.validator,
    this.onSaved,
    this.isPassword = false,
    this.isEmail = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsets.all(15.0),
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.grey[200],
        ),
        obscureText: isPassword ? true : false,
        validator: validator,
        onSaved: onSaved,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      ),
    );
  }
}
