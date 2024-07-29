import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService{

  // get instance of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
}