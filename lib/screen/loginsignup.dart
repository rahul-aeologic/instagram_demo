import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:instagram_demo/screen/homeScreen.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

class LoginSignup extends StatefulWidget {
  const LoginSignup({Key? key}) : super(key: key);

  @override
  _LoginSignupState createState() => _LoginSignupState();
}

class _LoginSignupState extends State<LoginSignup> {
  final TextEditingController _userId = new TextEditingController();
  final TextEditingController _password = new TextEditingController();

  var _textStyleBlack = new TextStyle(fontSize: 12.0, color: Colors.black);
  var _textStyleGrey = new TextStyle(fontSize: 12.0, color: Colors.grey);
  var _textStyleBlueGrey =
      new TextStyle(fontSize: 12.0, color: Colors.blueGrey);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      bottomNavigationBar: _bottomBar(),
      body: SingleChildScrollView(child: _body()),
    );
  }

  Widget _userIDEditContainer() {
    return new Container(
      child: new TextField(
        controller: _userId,
        decoration: new InputDecoration(
            hintText: 'Phone number,email or username',
            border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.black),
            ),
            isDense: true),
        style: _textStyleBlack,
      ),
    );
  }

  Widget _passwordEditContainer() {
    return new Container(
      padding: const EdgeInsets.only(top: 5.0),
      child: new TextField(
        controller: _password,
        obscureText: true,
        decoration: new InputDecoration(
            hintText: 'Password',
            border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.black),
            ),
            isDense: true),
        style: _textStyleBlack,
      ),
    );
  }

  Widget _loginContainer() {
    return new GestureDetector(
      onTap: _loginWithEmailPassword,
      child: new Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 10.0),
        width: 500.0,
        height: 40.0,
        child: new Text(
          "Log In",
          style: new TextStyle(color: Colors.white),
        ),
        color: Colors.blue,
      ),
    );
  }

  Widget _facebookContainer() {
    return new Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 10.0),
      width: 500.0,
      height: 40.0,
      color: Colors.blue,
      child: new GestureDetector(
        onTap: () {
          print('facebook btn clicked');
        },
        child: new Text(
          "Log in with facebook",
          style:
              new TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _googleContainer() {
    return new Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 10.0),
      width: 500.0,
      height: 40.0,
      color: Colors.blue,
      child: new GestureDetector(
        onTap: () {
          googleSignIn(context);
        },
        child: new Text(
          "Log in with google",
          style:
              new TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _twitterContainer() {
    return new Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 10.0),
      width: 500.0,
      height: 40.0,
      color: Colors.blue,
      child: new GestureDetector(
        onTap: () {
          print('twitter btn clicked');
        },
        child: new Text(
          "Log in with twitter",
          style:
              new TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _gitHubContainer() {
    return new Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 10.0),
      width: 500.0,
      height: 40.0,
      color: Colors.blue,
      child: new GestureDetector(
        onTap: () {
          print('github btn clicked');
        },
        child: new Text(
          "Log in with GitHub",
          style:
              new TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _shareInstagramApp() {
    return new Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 10.0),
      width: 500.0,
      height: 40.0,
      color: Colors.blue,
      child: new GestureDetector(
        onTap: () {
          print('share btn clicked');
        },
        child: new Text(
          "Share Instagram",
          style:
              new TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _bottomBar() {
    return new Container(
        alignment: Alignment.center,
        height: 50.0,
        child: new Column(
          children: <Widget>[
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  height: 1.0,
                  color: Colors.grey.withOpacity(0.7),
                ),
                new Padding(
                  padding: new EdgeInsets.only(top: 17.5),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text(' Dont have an account?', style: _textStyleGrey),
                      new Text('Sign up.', style: _textStyleBlueGrey),
                    ],
                  ),
                )
              ],
            )
          ],
        ));
  }

  Widget _body() {
    return new Container(
      color: Colors.white,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(25.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.only(top: 25.0, bottom: 15.0),
            child: new Text(
              'Instagram',
              style: new TextStyle(fontFamily: 'Billabong', fontSize: 55.0),
            ),
          ),
          _userIDEditContainer(),
          _passwordEditContainer(),
          _loginContainer(),
          SizedBox(
            height: 10,
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(
                height: 1.0,
                width: MediaQuery.of(context).size.width / 2.7,
                color: Colors.grey,
                child: new ListTile(),
              ),
              new Text(
                ' OR ',
                style: new TextStyle(color: Colors.blueGrey),
              ),
              new Container(
                height: 1.0,
                width: MediaQuery.of(context).size.width / 2.7,
                color: Colors.grey,
              ),
            ],
          ),
          //_facebookContainer(),
          _googleContainer(),
          //_twitterContainer(),
          //_gitHubContainer(),
          //_shareInstagramApp(),
        ],
      ),
    );
  }

  void _loginWithEmailPassword() async {
    if (_userId.text.isEmpty) {
      _showEmptyDialog("Please enter username");
    } else if (_password.text.isEmpty) {
      _showEmptyDialog("Please enter password");
    } else {
      try {
        final FirebaseUser user = (await _auth.signInWithEmailAndPassword(
          email: _userId.text,
          password: _password.text,
        ))
            .user;
        if (user != null) {
          final route = MaterialPageRoute(
              builder: (context) =>
                  HomeScreen(user.displayName, user.photoUrl, user.email));
          Navigator.push(context, route);
          // String email = _userId.text;
          print(user.email);
          print('Log In Successfully......');
          // _setUserEmail(email);
        }
      } catch (e) {
        _showEmptyDialog("Incorrect username & password");
      }
    }
  }

  // void _facebooLogin() async {
  //   final FacebookLoginResult result = await facebookSignIn.logIn(['email']);
  //
  //   switch (result.status) {
  //     case FacebookLoginStatus.loggedIn:
  //       final FacebookAccessToken accessToken = result.accessToken;
  //       _showEmptyDialog('''
  //        Logged in!
  //
  //        Token: ${accessToken.token}
  //        User id: ${accessToken.userId}
  //        Expires: ${accessToken.expires}
  //        Permissions: ${accessToken.permissions}
  //        Declined permissions: ${accessToken.declinedPermissions}
  //        ''');
  //       break;
  //     case FacebookLoginStatus.cancelledByUser:
  //       _showEmptyDialog('Login cancelled by the user.');
  //       break;
  //     case FacebookLoginStatus.error:
  //       _showEmptyDialog('Something went wrong with the login process.\n'
  //           'Here\'s the error Facebook gave us: ${result.errorMessage}');
  //       break;
  //   }
  // }

  // void _logOut() async {
  //    await facebookSignIn.logOut();
  //    _showEmptyDialog('Log out');
  //  }

  Future<void> googleSignIn(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final route = MaterialPageRoute(
          builder: (context) => HomeScreen(googleSignInAccount.email,
              googleSignInAccount.displayName, googleSignInAccount.photoUrl));
      await _auth.signInWithCredential(credential).then((value) {
        Navigator.push(context, route);
      });
    } catch (e) {
      _showEmptyDialog('Google signin failed');
    }
  }

  _showEmptyDialog(String title) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => new CupertinoAlertDialog(
              content: new Text("$title"),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: new Text("OK"))
              ],
            ));
  }
}
