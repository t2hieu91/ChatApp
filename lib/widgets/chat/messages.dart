import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('chat')
          .orderBy(
            'createdAt',
            descending: true,
          )
          .snapshots(),
      builder: (ctx, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        final chatDocuments = chatSnapshot.data.documents;
        return ListView.builder(
          reverse: true,
          itemCount: chatDocuments.length,
          itemBuilder: (ctx, index) => Text(chatDocuments[index]['text']),
        );
      },
    );
  }
}
