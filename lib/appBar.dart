import 'package:flutter/material.dart';
import 'login.dart';
import 'main.dart';
import 'package:provider/provider.dart';
import 'package:balistos/models/state.model.dart';

class BalistosAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFF333333),
      title: Text("Balistos"),
      leading: IconButton(
        icon: Image.asset('assets/images/logo.png'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        },
        tooltip: "Balistos logo",
      ),
      actions: <Widget>[
        Consumer<StateModel>(builder: (context, state, child) {
          return (state.loggedInUser != null
              ? new Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  width: 36,
                  height: 36,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image:
                              new NetworkImage(state.loggedInUser.photoUrl))))
              : IconButton(
                  icon: Image.asset('assets/images/user.png'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginRoute()),
                    );
                  },
                  tooltip: "Balistos logo",
                ));
        }
            // action button
            )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
