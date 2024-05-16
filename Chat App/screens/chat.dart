import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:chat_app/widgets/chat_messages.dart';
import 'package:chat_app/widgets/new_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void setupPushNotifications() async {
    final fcm = FirebaseMessaging.instance;
    // final token = await fcm.getToken();
    // print(token);
    await fcm.requestPermission();
    fcm.subscribeToTopic('chat');
  }

  @override
  void initState() {
    _setupMessageListener();
    super.initState();

    setupPushNotifications();
  }

  void _setupMessageListener() {
    FirebaseFirestore.instance
        .collection('chat')
        .snapshots()
        .listen((snapshot) {
      final user = FirebaseAuth.instance.currentUser!;
      snapshot.docChanges.forEach((change) {
        if (change.type == DocumentChangeType.added &&
            change.doc['userId'] != user.uid) {
          // Trigger local notification
          _triggerNotification(change.doc['text'], change.doc['username']);
        }
      });
    });
  }

  void _triggerNotification(String message, String uname) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'basic',
        title: 'New Message by $uname',
        body: message,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlutterChat'),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: Icon(
                Icons.exit_to_app,
                color: Theme.of(context).colorScheme.primary,
              ))
        ],
      ),
      body: const Column(
        children: [
          Expanded(
            child: ChatMessages(),
          ),
          NewMessage(),
        ],
      ),
    );
  }
}
