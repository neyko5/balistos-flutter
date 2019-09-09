import 'package:flutter/material.dart';
import '../components/Playlists.dart';
import 'package:balistos/components/SearchPlaylist.dart';

import '../appBar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: BalistosAppBar(),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: Container(
            color: Color.fromARGB(255, 234, 234, 234),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(children: <Widget>[
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/back.png'),
                          fit: BoxFit.cover),
                    ),
                    child: SearchPlaylist(),
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(bottom: 10),
                  ),
                  new Playlists()
                ])
              ],
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
