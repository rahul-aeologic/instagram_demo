import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:instagram_demo/screen/loginsignup.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Text('Hello Insta')),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 10.0),
                width: 100.0,
                height: 40.0,
                color: Colors.blue,
                child: new GestureDetector(
                  onTap: () {
                    signOutFromGoogle();
                  },
                  child: new Text(
                    "Sign out",
                    style: new TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signOutFromGoogle() async {
    await _googleSignIn.signOut();
    await _auth.signOut().then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => LoginSignup())));
  }

}
