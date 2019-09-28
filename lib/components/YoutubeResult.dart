import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../models/state.model.dart';

class YoutubeResult extends StatelessWidget {
  final item;
  final playlistId;
  const YoutubeResult(this.item, this.playlistId);

  void addVideo(context) async {
    final userId =
        Provider.of<StateModel>(context, listen: false).loggedInUser.uid;
    final CollectionReference videosRef =
        Firestore.instance.collection('playlists/${this.playlistId}/videos');

    await videosRef.add({
      "youtube_id": item.id,
      "title": item.title,
      "creator_id": userId,
      "created_at": FieldValue.serverTimestamp()
    });
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text(
        "Video added",
        textAlign: TextAlign.center,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: () => addVideo(context),
      child: Container(
        height: 54,
        color: Color.fromARGB(255, 232, 232, 232),
        margin: const EdgeInsets.only(bottom: 5.0),
        child: Row(
          children: [
            Container(
              width: 54,
              height: 54,
              margin: EdgeInsets.only(right: 5),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(this.item.thumbnail['medium']['url']),
                    fit: BoxFit.cover),
              ),
            ),
            Flexible(
              child: Text(
                this.item.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            )
          ],
        ),
      ),
    );
  }
}
