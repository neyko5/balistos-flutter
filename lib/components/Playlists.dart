import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './PlaylistItems.dart';
import '../models/playlist.model.dart';

class Playlists extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('playlists').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Text('Loading...');
            default:
              return new PlaylistItems(snapshot.data.documents
                  .map((DocumentSnapshot document) => new Playlist(
                      document.reference.documentID,
                      document.data['title'],
                      document.data['description']))
                  .toList());
          }
        });
  }
}
