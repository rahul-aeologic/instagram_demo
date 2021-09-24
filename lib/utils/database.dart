import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;
final CollectionReference _mainCollection = _firestore.collection('users');

class Database {
  //static String? userUid;

  static Future<void> addItem({
    required String name,
    required String username,
    required String userImageUrl,
    required String title,
    required String imageUrl,
  }) async {
    DocumentReference documentReferencer = _mainCollection.document();

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "name": name,
      "username":username,
      "userImageUrl": userImageUrl,
      "imageUrl": imageUrl,
    };

    await documentReferencer
        .setData(data)
        .whenComplete(() => print("Note item added to the database"))
        .catchError((e) => print(e));
  }

  static Future<void> updateItem({
    required String title,
    required String description,
    required String docId,
    required String imageUrl,
  }) async {
    DocumentReference documentReferencer = _mainCollection.document(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "description": description,
      "imageUrl": imageUrl,
    };

    await documentReferencer
        .updateData(data)
        .whenComplete(() => print("Note item updated in the database"))
        .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot> readItems() {
    CollectionReference notesItemCollection = _mainCollection;

    return notesItemCollection.snapshots();
  }

  static Future<void> deleteItem({
    required String docId,
  }) async {
    DocumentReference documentReferencer = _mainCollection.document(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Note item deleted from the database'))
        .catchError((e) => print(e));
  }
}
