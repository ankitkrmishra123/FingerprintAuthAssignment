import 'dart:io';

import 'package:fingerprintauthflutter/editprofilepage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'Profile_page.dart';
import 'model.dart';

class UserProfilePage extends StatefulWidget {
  Model model;
  UserProfilePage({Key key, @required this.model}) : super(key: key);
  @override
  _UserProfilePageState createState() => _UserProfilePageState(model);
}

class _UserProfilePageState extends State<UserProfilePage> {

  Model _model;
  _UserProfilePageState(this._model);

   File _image;
  final picker = ImagePicker();
   String _fullName;
   String _status;
   String _bio;
//      "\"Hi, I am a Flutter developer working for assignment currently. If you wants to contact me to build your product leave a message.\"";
  final String _followers = "173";
  final String _posts = "24";
  final String _scores = "450";


  _imgFromCamera() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.camera, imageQuality: 50
    );

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  _imgFromGallery() async {
    final pickedFile = await  picker.getImage(
        source: ImageSource.gallery, imageQuality: 50
    );

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }


  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  Widget _buildCoverImage(Size screenSize) {
    return Container(
      height: screenSize.height / 2.6,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Center(
      child: GestureDetector(
        onTap: (){
          _showPicker(context);
        },
        child: CircleAvatar(
          radius: 55,
          backgroundColor: Color(0xffFDCF09),
          child: _image != null
              ? ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.file(
              _image,
              width: 100,
              height: 100,
              fit: BoxFit.fitHeight,
            ),
          )
              : Container(
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(50)),
            width: 100,
            height: 100,
            child: Icon(
              Icons.camera_alt,
              color: Colors.grey[800],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFullName() {
    TextStyle _nameTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
    );

    return Text(
      _fullName,
      style: _nameTextStyle,
    );
  }

  Widget _buildStatus(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        _status,
        style: TextStyle(
          fontFamily: 'Spectral',
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String count) {
    TextStyle _statLabelTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 16.0,
      fontWeight: FontWeight.w200,
    );

    TextStyle _statCountTextStyle = TextStyle(
      color: Colors.black54,
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count,
          style: _statCountTextStyle,
        ),
        Text(
          label,
          style: _statLabelTextStyle,
        ),
      ],
    );
  }

  Widget _buildStatContainer() {
    return Container(
      height: 60.0,
      margin: EdgeInsets.only(top: 8.0),
      decoration: BoxDecoration(
        color: Color(0xFFEFF4F7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildStatItem("Followers", _followers),
          _buildStatItem("Posts", _posts),
          _buildStatItem("Scores", _scores),
        ],
      ),
    );
  }

  Widget _buildBio(BuildContext context) {
    TextStyle bioTextStyle = TextStyle(
      fontFamily: 'Spectral',
      fontWeight: FontWeight.w400,//try changing weight to w500 if not thin
      fontStyle: FontStyle.italic,
      color: Color(0xFF799497),
      fontSize: 16.0,
    );

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.all(8.0),
      child: Text(
        _bio,
        textAlign: TextAlign.center,
        style: bioTextStyle,
      ),
    );
  }

  Widget _buildSeparator(Size screenSize) {
    return Container(
      width: screenSize.width / 1.6,
      height: 2.0,
      color: Colors.black54,
      margin: EdgeInsets.only(top: 4.0),
    );
  }

  Widget _buildGetInTouch(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.only(top: 8.0),
      child: Text(
        "Get in Touch with ${_fullName.split(" ")[0]},",
        style: TextStyle(fontFamily: 'Roboto', fontSize: 16.0),
      ),
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: () => print("followed"),
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: Color(0xFF404A5C),
                ),
                child: Center(
                  child: Text(
                    "FOLLOW",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: InkWell(
              onTap: () => print("Message"),
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "MESSAGE",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _fullName = _model.firstName +" "+ _model.lastName;
    _status = _model.email;
    _bio = _model.shortbio;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildCoverImage(screenSize),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: screenSize.height / 6.4),
                  _buildProfileImage(),
                  SizedBox(height: 60.0),
                  _buildFullName(),
                  _buildStatus(context),
                  _buildStatContainer(),
                  _buildBio(context),
                  _buildSeparator(screenSize),
                  SizedBox(height: 10.0),
                  _buildGetInTouch(context),
                  SizedBox(height: 8.0),
                  _buildButtons(),
                  SizedBox(height: 38.0),
                  _editProfileAndFriends(),
//                  _yourFriends(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

 Widget _editProfileAndFriends() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: GestureDetector(child: RaisedButton(child: Text('Edit Profile', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16))),
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Edit_Profile()));
          })
        ),
        SizedBox(width: 103),
        Container(
            child: GestureDetector(child: RaisedButton(child: Text('your friends', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16))), onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserFriends_ProfilePage()));
            })
        ),
      ],
    );
 }


//  Widget _yourFriends() {
//    return Container(
//        margin: EdgeInsets.fromLTRB(0, 43, 184, 34),
//        child: RaisedButton(child: Text('your friends', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 23)))
//    );
//  }
}
