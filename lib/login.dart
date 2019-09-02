import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginRoute extends StatefulWidget {
  LoginRoute({Key key, this.title}) : super(key: key);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _LoginData {
  String email = '';
  String password = '';
}

class _MyHomePageState extends State<LoginRoute> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  FirebaseUser user;
  _LoginData _data = new _LoginData();
  TextStyle style =
      TextStyle(fontFamily: 'Open Sans', fontSize: 20.0, color: Colors.black);

  void _handleSignIn() async {
    print(_formKey.currentState);
    _formKey.currentState.save();
    final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
      email: _data.email,
      password: _data.password,
    ));
    setState(() {
      this.user = user;
    });
  }

  Future<FirebaseUser> _handleGoogleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user =
        (await _auth.signInWithCredential(credential));
    print("signed in " + user.displayName);
    setState(() {
      this.user = user;
    });
    return user;
    
  }

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      obscureText: false,
      style: style,
      onSaved: (String value) {
        this._data.email = value;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(11.0, 10.0, 11.0, 10.0),
        hintText: "Username",
        filled: true,
        fillColor: Color.fromARGB(255, 247, 249, 249),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3.0),
          borderSide:
              BorderSide(color: Color.fromARGB(255, 217, 224, 226), width: 1),
        ),
      ),
    );
    final passwordField = TextFormField(
      obscureText: true,
      style: style,
      onSaved: (String value) {
        this._data.password = value;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(11.0, 10.0, 11.0, 10.0),
        hintText: "Password",
        filled: true,
        fillColor: Color.fromARGB(255, 247, 249, 249),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3.0),
          borderSide:
              BorderSide(color: Color.fromARGB(255, 217, 224, 226), width: 1),
        ),
      ),
    );
    final loginButon = RaisedButton(
        elevation: 5.0,
        color: Color.fromARGB(255, 177, 187, 0),
        child: Text(
          "Submit",
          style: TextStyle(color: Colors.white),
        ),
        onPressed: _handleSignIn);

    final googleLoginButon = RaisedButton(
        elevation: 5.0,
        color: Color.fromARGB(255, 177, 187, 0),
        child: Text(
          "Google login",
          style: TextStyle(color: Colors.white),
        ),
        onPressed: _handleGoogleSignIn);

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(this.user != null ? this.user.email : ""),
                  SizedBox(height: 45.0),
                  emailField,
                  SizedBox(height: 25.0),
                  passwordField,
                  SizedBox(
                    height: 35.0,
                  ),
                  loginButon,
                  googleLoginButon,
                  SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
