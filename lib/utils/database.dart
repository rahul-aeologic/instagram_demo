import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('posts');
final CollectionReference _likeDislikeCollection =
    _firestore.collection('posts/likes');

class Database {
  static Future<void> addItem({
    required String name,
    required String username,
    required String userImageUrl,
    required String title,
    required String imageUrl,
    required String time,
  }) async {
    DocumentReference documentReferencer = _mainCollection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "name": name,
      "username": username,
      "userImageUrl": userImageUrl,
      "imageUrl": imageUrl,
      "time": time,
      "likes": '0',
      "isLiked": false,
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("Note item added to the database"))
        .catchError((e) => print(e));
  }

  static Future<void> updateItem({
    required String title,
    required String description,
    required String docId,
    required String imageUrl,
    required String time,
  }) async {
    DocumentReference documentReferencer = _mainCollection.doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "description": description,
      "imageUrl": imageUrl,
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => print("Note item updated in the database"))
        .catchError((e) => print(e));
  }

  static Future<void> likeDislike({
    required String like,
    required String postId,
    required bool isLiked,
  }) async {
    DocumentReference documentReferencer = _mainCollection.doc(postId);

    Map<String, dynamic> data = <String, dynamic>{
      "likes": like,
      "isLiked": isLiked,
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => print("Note item updated in the database"))
        .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot> readPosts() {
    CollectionReference postsCollection = _mainCollection;

    return postsCollection.orderBy('time',descending: true).snapshots();
  }

  static Future<void> deleteItem({
    required String docId,
  }) async {
    DocumentReference documentReferencer = _mainCollection.doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Note item deleted from the database'))
        .catchError((e) => print(e));
  }
}
