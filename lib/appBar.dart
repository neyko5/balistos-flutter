import 'package:flutter/material.dart';
import 'login.dart';

class BalistosAppBar extends StatelessWidget implements PreferredSizeWidget {
    @override
    Widget build(BuildContext context) {
      return AppBar(
        backgroundColor: Color(0xFF333333),
        title: Text("Balistos"),
        leading: IconButton(
          icon: Image.asset('assets/images/logo.png'),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          tooltip: "Balistos logo",
        ),
        actions: <Widget>[
          // action button
          IconButton(
            icon: Image.asset('assets/images/user.png'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginRoute()),
              );
            },
            tooltip: "Balistos logo",
          )
        ],
      );
    } 

    @override
    Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
