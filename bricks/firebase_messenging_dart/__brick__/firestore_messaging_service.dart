import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import '../models/user_model.dart';

class FirestoreMessagingService {
  static FirestoreMessagingService get instance => FirestoreMessagingService();

  void updateFcmToken(String userId) {
    debugPrint('updateFcmToken');
    FirebaseMessaging.instance.getToken().then((fcmToken) async {
      final DocumentReference doc =
          FirebaseFirestore.instance.collection('users').doc(userId);
      doc.get().then((docSnapshot) {
        if (docSnapshot.exists) {
          doc.update({'fcmToken': fcmToken ?? 'NoToken'});
          debugPrint(fcmToken);
        }
      });
    });
  }

  Future<String> saveUserData(User user) async {
    final String myId = user.id.toString();
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: user.id)
        .get();
    final List<DocumentSnapshot> documents = result.docs;

    if (documents.isEmpty) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.id.toString())
          .set({
        // 'lastChatWith': userID == myID ? selectedUserID : myID,
        'id': user.id,
        'isFriend': false,
        'name': user.fullName,
        'image': user.userImage?.path ?? '',
        'createdAt': user.createdAt,
      });
    }
    return myId;
  }

  Future<bool> updateUserData(User user) async {
    final DocumentReference doc =
        FirebaseFirestore.instance.collection('users').doc(user.id.toString());
    doc.get().then((docSnapshot) async {
      if (docSnapshot.exists) {
        await doc.update({
          'name': user.fullName,
          'image': user.userImage?.path ?? '',
        });
      }
    });
    return true;
  }

  Future<bool> deleteUserData(String userId) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).delete();
    return true;
  }

  // Future<String> updateSocialLoginUserData(AccessResponse loginResponse) async {
  //   DocumentReference doc = FirebaseFirestore.instance
  //       .collection(AppStrings.FIREBASE_USERS_NODE)
  //       .doc(loginResponse.user!.id.toString());
  //   doc.get().then((docSnapshot) {
  //     if (docSnapshot.exists) {
  //       doc.update({
  //         'is_greek': loginResponse.user!.isGreek,
  //       }).then((value) {
  //         loginResponse.user!.userUniversities!.forEach((element) async {
  //           await FirebaseFirestore.instance
  //               .collection(AppStrings.FIREBASE_USERS_NODE)
  //               .doc(loginResponse.user!.id.toString())
  //               .collection('universities')
  //               .doc(element.id.toString())
  //               .set({
  //             // 'lastChatWith': userID == myID ? selectedUserID : myID,
  //             'id': element.id,
  //             'name': element.name,
  //             'createdAt': element.createdAt,
  //           });
  //         });
  //       });
  //     }
  //   });
  //   return "";
  // }

  // Future<String> updateUserFirebaseToken(String userId, String token) async {
  //   DocumentReference doc = FirebaseFirestore.instance
  //       .collection(AppStrings.FIREBASE_USERS_NODE)
  //       .doc(userId);
  //   doc.get().then((docSnapshot) {
  //     if (docSnapshot.exists) {
  //       doc.update({'fcmToken': token});
  //     }
  //   });
  //   return "";
  // }

  Future updateChatRequestField({
    required int timeStamp,
    String? userID,
    String? lastMessage,
    String? chatID,
    String? myID,
    String? selectedUserID,
    String? name,
    String? image,
  }) async {
    debugPrint('updateChatRequestField');
    debugPrint('$updateChatRequestField---$userID');
    // final QuerySnapshot result = await FirebaseFirestore.instance
    //     .collection('users')
    //     .where('id', isEqualTo: userID)
    //     .get();
    // final List<DocumentSnapshot> documents = result.docs;

    //if (documents.isNotEmpty) {
    debugPrint('updateChatRequestField');
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('chatList')
        .doc(chatID)
        .set({
      'chatID': chatID,
      'name': name,
      'image': image,
      'chatWith': userID == myID ? selectedUserID : myID,
      'lastChat': lastMessage,
      'timestamp': timeStamp,
      "chatDeleteTimeStamp": 0,
    });
    // }
  }

  Future updateFriend({String? userID, required bool isFriend}) async {
    await FirebaseFirestore.instance.collection('users').doc(userID).update({
      'isFriend': isFriend,
    });
  }

  Future blockFriend({
    String? userID,
    String? chatID,
    required int isBlocked,
    required int hasBlocked,
  }) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('chatlist')
        .doc(chatID)
        .update({
      'isBlocked': isBlocked,
      'hasBlocked': hasBlocked,
    });
  }

  Future saveMsgToChatRoom({
    String? chatId,
    String? myId,
    String? selectedUserId,
    String? content,
    required int timeStamp,
  }) async {
    FirebaseFirestore.instance
        .collection('messages')
        .doc(chatId)
        .collection(chatId!)
        .doc(timeStamp.toString())
        .set({
      'chatId': chatId,
      'idFrom': myId,
      'idTo': selectedUserId,
      'timestamp': timeStamp,
      'content': content,
      'isRead': false,
    });
  }

  Future<int> getIsFriend({
    required String userID,
    required String chatID,
  }) async {
    final DocumentSnapshot result = await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection("chatlist")
        .doc(chatID)
        .get();

    if (result.exists) {
      debugPrint('result.get(isFriend) ${result.get('isFriend')}');
      return result.get('isFriend');
    } else {
      return 0;
    }
  }

  Future<bool> ifChatExists({
    required String userID,
    required String chatID,
  }) async {
    final DocumentSnapshot result = await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection("chatList")
        .doc(chatID)
        .get();

    if (result.exists) {
      return true;
    } else {
      return false;
    }
  }

  Future updateChatListItem({
    required int timeStamp,
    String? userID,
    String? lastMessage,
    String? chatID,
  }) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('chatList')
        .doc(chatID)
        .update({
      'lastChat': lastMessage,
      'timestamp': timeStamp,
    });
  }

  Future deleteChat({
    required int timeStamp,
    required String chatID,
    required String userId,
  }) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('chatlist')
        .doc(chatID)
        .update({
      "chatDelete": 1,
      "chatDeleteTimeStamp": timeStamp,
    });
  }
}
