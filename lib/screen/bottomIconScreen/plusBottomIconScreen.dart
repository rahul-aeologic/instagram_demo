import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_demo/utils/database.dart';

class PlusBottomIconScreen extends StatefulWidget {
  String name;
  String username;
  String profileUrl;
  String idToken;

  PlusBottomIconScreen(
    this.name,
    this.username,
    this.profileUrl,
    this.idToken,
  );

  @override
  _PlusBottomIconScreenState createState() => _PlusBottomIconScreenState();
}

class _PlusBottomIconScreenState extends State<PlusBottomIconScreen> {
  final database = FirebaseFirestore.instance.collection('users');
  Reference storageReference = FirebaseStorage.instance.ref();
  TextEditingController _textEditingController = TextEditingController();
  late File _image;
  late String url;
  late Uint8List profileImage;
  final picker = ImagePicker();

  bool flag = false;
  bool isImageLoaded = false;

  putImage() async {
    profileImage = await _image.readAsBytes();
    var uploadTask =
        storageReference.child(widget.idToken).putData(profileImage);
    TaskSnapshot taskSnapshot = await uploadTask;
    url = await taskSnapshot.ref.getDownloadURL();
    print(url);
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        isImageLoaded = true;
        _image = File(pickedFile.path);
      } else {
        isImageLoaded = false;
        print('No image selected.');
      }
    });
  }

  _uploadData(String title) async {
    setState(() {
      flag = true;
    });
    try {
      await putImage();
      await Database.addItem(
        name: widget.name,
        username: widget.username,
        userImageUrl: widget.profileUrl,
        title: title,
        imageUrl: url,
      ).then((value) {
        setState(() {
          flag = false;
          isImageLoaded = false;
        });
        _showEmptyDialog('Data Uploaded');
      });
    } catch (e) {
      print('error throw: $e');
      flag = false;
    }
  }

  @override
  void initState() {
    getImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
        child: flag
            ? Center(child: CircularProgressIndicator())
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      getImage();
                    },
                    child: isImageLoaded
                        ? Container(height: 200, child: Image.file(_image))
                        : Container(
                            margin:
                                EdgeInsets.only(left: 20, right: 20, top: 10),
                            decoration: BoxDecoration(
                              color: Colors.black12,
                            ),
                            alignment: Alignment.center,
                            height: 200,
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.grey[800],
                            )),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 40, right: 40),
                    padding: EdgeInsets.only(bottom: 10.0, top: 10),
                    child: TextField(
                      controller: _textEditingController,
                      maxLines: 2,
                      decoration: InputDecoration(
                        hintText: "write caption",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 40, right: 40),
                    child: ElevatedButton(
                      child: Text('Upload'),
                      onPressed: () async {
                        await _uploadData(_textEditingController.text);
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  _showEmptyDialog(String title) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => new CupertinoAlertDialog(
              content: new Text("$title"),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: new Text("OK"))
              ],
            ));
  }
}
