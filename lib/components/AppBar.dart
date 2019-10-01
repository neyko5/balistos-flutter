import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/state.model.dart';
import '../pages/login.dart';

class BalistosAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFF333333),
      title: Text("Balistos"),
      leading: IconButton(
        icon: Image.asset('assets/images/logo.png'),
        onPressed: () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
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
