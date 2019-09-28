import 'package:balistos/models/playlist.model.dart';
import 'package:balistos/pages/detail.dart';
import 'package:flutter/material.dart';

class PlaylistItem extends StatelessWidget {
  final playlistIndex;
  final Playlist playlist;

  const PlaylistItem({
    this.playlistIndex,
    this.playlist,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: () {
        final page = DetailPage(playlistId: this.playlist.id);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Container(
        height: 54,
        margin: const EdgeInsets.only(bottom: 5.0),
        child: Row(children: [
          Container(
              width: 54,
              height: 54,
              color: Colors.white,
              child: Text(
                this.playlistIndex.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    height: 1.5,
                    fontWeight: FontWeight.w300,
                    color: Color.fromARGB(255, 117, 128, 0),
                    fontSize: 34),
              )),
          Expanded(
            child: Container(
              constraints: BoxConstraints.expand(),
              height: double.infinity,
              color: Color.fromARGB(255, 221, 221, 221),
              padding: new EdgeInsets.all(5),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        this.playlist.title,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 51, 51, 51),
                            fontSize: 20),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        this.playlist.description,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic,
                            color: Color.fromARGB(255, 102, 102, 102),
                            fontSize: 12),
                      ),
                    ),
                  ]),
            ),
          )
        ]),
      ),
    );
  }
}
