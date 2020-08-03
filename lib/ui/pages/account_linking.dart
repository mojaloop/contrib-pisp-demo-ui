// Copyright 2017, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pispapp/controllers/app/auth_controller.dart';


class MessageList extends StatelessWidget {
  MessageList();

  final Firestore firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore
          .collection("messages")
          .orderBy("created_at", descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return const Text('Loading...');
        final int messageCount = snapshot.data.documents.length;
        return ListView.builder(
          itemCount: messageCount,
          itemBuilder: (_, int index) {
            final DocumentSnapshot document = snapshot.data.documents[index];
            final dynamic message = document['message'];
            return ListTile(
              trailing: IconButton(
                onPressed: () => document.reference.delete(),
                icon: Icon(Icons.delete),
              ),
              title: Text(
                message != null ? message.toString() : '<No message retrieved>',
              ),
              subtitle: Text('Message ${index + 1} of $messageCount'),
            );
          },
        );
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage();

  final Firestore firestore = Firestore.instance;

  CollectionReference get messages => firestore.collection('transactions');

  Future<void> _addMessage() async {
    await messages.add(<String, dynamic>{
      'userId': Get.find<AuthController>().user.uid, 
      'payee': {
        'partyIdInfo': {
          'partyIdType': 'MSISDN',
          'partyIdentifier': '+91-9999999999',
        }
      }
      
    });
  }

  Future<void> _runTransaction() async {
    firestore.runTransaction((Transaction transaction) async {
      final allDocs = await firestore.collection("messages").getDocuments();
      final toBeRetrieved =
          allDocs.documents.sublist(allDocs.documents.length ~/ 2);
      final toBeDeleted =
          allDocs.documents.sublist(0, allDocs.documents.length ~/ 2);
      await Future.forEach(toBeDeleted, (DocumentSnapshot snapshot) async {
        await transaction.delete(snapshot.reference);
      });

      await Future.forEach(toBeRetrieved, (DocumentSnapshot snapshot) async {
        await transaction.update(snapshot.reference, <String, dynamic>{
          "message": "Updated from Transaction",
          "created_at": FieldValue.serverTimestamp()
        });
      });
    });

    await Future.forEach(List.generate(2, (index) => index), (dynamic item) async {
      await firestore.runTransaction((Transaction transaction) async {
        await Future.forEach(List.generate(10, (index) => index), (dynamic  item) async {
          await transaction.set(firestore.collection("messages").document(), <String, dynamic>{
            "message": "Created from Transaction $item",
            "created_at": FieldValue.serverTimestamp()
          });
        });
      });
    });
  }

  Future<void> _runBatchWrite() async {
    final batchWrite = firestore.batch();
    final querySnapshot = await firestore
        .collection("messages")
        .orderBy("created_at")
        .limit(12)
        .getDocuments();
    querySnapshot.documents
        .sublist(0, querySnapshot.documents.length - 3)
        .forEach((DocumentSnapshot doc) {
      batchWrite.updateData(doc.reference, <String, dynamic>{
        "message": "Batched message",
        "created_at": FieldValue.serverTimestamp()
      });
    });
    batchWrite.setData(firestore.collection("messages").document(), <String, dynamic>{
      "message": "Batched message created",
      "created_at": FieldValue.serverTimestamp()
    });
    batchWrite.delete(
        querySnapshot.documents[querySnapshot.documents.length - 2].reference);
    batchWrite.delete(querySnapshot.documents.last.reference);
    await batchWrite.commit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firestore Example'),
        actions: <Widget>[
          FlatButton(
            onPressed: _runTransaction,
            child: Text("Run Transaction"),
          ),
          FlatButton(
            onPressed: _runBatchWrite,
            child: Text("Batch Write"),
          )
        ],
      ),
      body: MessageList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _addMessage,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}