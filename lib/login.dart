import 'package:flutter/material.dart';

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

class _MyHomePageState extends State<LoginRoute> {
  TextStyle style =
      TextStyle(fontFamily: 'Open Sans', fontSize: 20.0, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
      obscureText: false,
      style: style,
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
    final passwordField = TextField(
      obscureText: true,
      style: style,
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
      color: Color.fromARGB(255,177, 187, 0),
      child: Text("Submit", style: TextStyle(color: Colors.white),),
      onPressed: () => print("logging in"),
      
    );

    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 155.0,
                  child: Image.asset(
                    "assets/images/logo.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 45.0),
                emailField,
                SizedBox(height: 25.0),
                passwordField,
                SizedBox(
                  height: 35.0,
                ),
                loginButon,
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
