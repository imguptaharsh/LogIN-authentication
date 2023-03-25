import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './auth_form.dart';

class ChatScreen extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ChatScreen({key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('/chats/PBtlw5iW8cUVhr61kdyH/massages')
            .snapshots(),
        builder: (context, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final documents = streamSnapshot.data.docs;
          return ListView.builder(
            itemCount: documents?.length,
            itemBuilder: ((context, index) => Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(documents[index]['text']),
                )),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => {
          FirebaseFirestore.instance
              .collection('/chats/PBtlw5iW8cUVhr61kdyH/massages')
              .add({'text': 'this wass added by clicking button'})
        },
      ),
    );
  }
}
