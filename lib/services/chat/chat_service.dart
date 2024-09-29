import 'package:chat_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService{

  // get instance of firestore & auth
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // get user stream
  /*

  [
  {
    'email': test@gmail.com,
    'id': ..
  },
  {
    'email': tt@gmail.com,
    'id': ..
  },
  ]

  */
  Stream<List<Map<String,dynamic>>> getUsersStream(){
    return _firestore.collection("Users").snapshots().map((snapshot){
      return snapshot.docs.map((doc){
        // go through each invidual user
        final user = doc.data();

        // returm user
        return user;
      }).toList();
    });
  }

  // send message
  Future<void> sendMessage(String receiverID, message) async {
    // get current user info
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    // create a new message
    Message newMessage = Message(
      senderID: currentUserID, 
      senderEmail: currentUserEmail, 
      receiverID: receiverID, 
      message: message, 
      timestamp: timestamp,
    );

    // construct chat room ID for the two users(sorted to ensure uniqueness)
    List<String> ids = [currentUserID, receiverID];
    ids.sort();
    String chatRoomID = ids.join('_');

    // add new message to database
    await _firestore
      .collection('chat_room')
      .doc(chatRoomID)
      .collection('message')
      .add(newMessage.toMap());
  }

  // get messages
  Stream<QuerySnapshot> getMessages(String userID, otherUserID){
    // construct chat room ID for the two users(sorted to ensure uniqueness)
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    // add new message to database
    return _firestore
      .collection('chat_room')
      .doc(chatRoomID)
      .collection('message')
      .orderBy('timestamp', descending: false)
      .snapshots();
  }
}