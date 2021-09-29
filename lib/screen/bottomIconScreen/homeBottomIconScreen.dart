import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_demo/utils/database.dart';

class HomeBottomIconScreen extends StatefulWidget {
  @override
  _HomeBottomIconScreenState createState() => _HomeBottomIconScreenState();
}

class _HomeBottomIconScreenState extends State<HomeBottomIconScreen> {
  bool _likeFlag = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
          brightness: Brightness.light,
          elevation: 0.4,
          backgroundColor: Colors.white,
          bottom: _appBar()),
      body: _body(),
    );
  }

  _appBar() {
    return new PreferredSize(
        child: new Container(
          color: Colors.white,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new IconButton(
                icon: new Icon(Icons.photo_camera),
                iconSize: 25.0,
                onPressed: () {},
              ),
              new Text(
                'Instagram',
                style: new TextStyle(
                    fontFamily: 'Billabong',
                    fontSize: 30.0,
                    color: Colors.black),
              ),
              new IconButton(
                icon: new Icon(Icons.near_me),
                iconSize: 25.0,
                onPressed: () {},
              ),
            ],
          ),
        ),
        preferredSize: Size.zero);
  }

  Widget _floatPic() {
    return Container(
      height: 100.0,
      color: Colors.white,
      child: new Column(
        children: <Widget>[
          new Flexible(
              child: new ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 21,
                  itemBuilder: (BuildContext context, int index) {
                    return new Container(
                      child: new Column(
                        children: <Widget>[
                          new Container(
                            margin: EdgeInsets.all(10.0),
                            child: new Image.asset(
                              (index == 0)
                                  ? "assets/images/your_acc.png"
                                  : "assets/images/friend_acc.png",
                              height: 60.0,
                            ),
                          ),
                          new Text((index == 0) ? "You" : " Friend $index")
                        ],
                      ),
                    );
                  })),
          new Container(
            height: 0.5,
            color: Colors.grey[300],
          )
        ],
      ),
    );
  }

  Widget _titleFriendAcc(String name, String userImageUrl) {
    return new Container(
      margin: EdgeInsets.all(8.0),
      child: new Row(
        children: <Widget>[
          new CircleAvatar(
            radius: 20,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  height: 38,
                  imageUrl: userImageUrl,
                )),
          ),
          // new CachedNetworkImage(imageUrl: userImageUrl,height: 40.0,),
          new Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: new Text(name),
          ),
        ],
      ),
    );
  }

  Widget _listImage(String imageUrl) {
    return Flexible(
      child: Container(
          child: new CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
      )),
    );
  }

  Widget _listBottom(
    isLiked,
    postId,
    like,
  ) {
    return new Container(
      margin: EdgeInsets.all(8.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Row(
            children: <Widget>[
              GestureDetector(
                  onTap: () async {
                    if (!isLiked) {
                      like = int.parse(like);
                      like = like + 1;
                      String likes = like.toString();
                      await Database.likeDislike(
                          postId: postId, like: likes, isLiked: true);
                    } else {
                      like = int.parse(like);
                      like = like - 1;
                      String likes = like.toString();
                      await Database.likeDislike(
                          postId: postId, like: likes, isLiked: false);
                    }
                  },
                  child: isLiked
                      ? new Icon(Icons.favorite, size: 30.0)
                      : new Icon(Icons.favorite_border, size: 30.0)),
              // new Padding(
              //   padding: EdgeInsets.only(left: 10.0, right: 10.0),
              //   child: new Icon(Icons.receipt, size: 30.0),
              // ),
              // new Icon(Icons.near_me, size: 30.0),
            ],
          ),
          new Icon(
            Icons.bookmark_border,
            size: 30.0,
          ),
        ],
      ),
    );
  }

  Widget _listBottomDate(
      String time, String like, String title, String username) {
    return new Container(
      margin: EdgeInsets.only(left: 10.0),
      child: new Column(
        children: <Widget>[
          new Container(
            alignment: Alignment.bottomLeft,
            child: new Text('${like == '0' ? '' : like + 'likes'}'),
          ),
          new Container(
            alignment: Alignment.bottomLeft,
            child: new Text(username + ': ' + title),
          ),
          new Container(
            margin: EdgeInsets.only(top: 2.0),
            alignment: Alignment.bottomLeft,
            child: new Text(
              time,
              style: TextStyle(color: Colors.grey, fontSize: 12.0),
            ),
          )
        ],
      ),
    );
  }

  Widget _listView() {
    return StreamBuilder<QuerySnapshot>(
      stream: Database.readPosts(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        } else if (snapshot.hasData || snapshot.data != null) {
          return Flexible(
              child: new ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    var postId = snapshot.data!.docs[index].id;
                    var noteInfo = snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;
                    String name = noteInfo['name'];
                    String username = noteInfo['username'];
                    String userImageUrl = noteInfo['userImageUrl'];
                    String title = noteInfo['title'];
                    String imageUrl = noteInfo['imageUrl'];
                    String time = noteInfo['time'];
                    String like = noteInfo['likes'];
                    bool isLiked = noteInfo['isLiked'];
                    return new Container(
                      child: Container(
                        color: Colors.white,
                        height: 390.0,
                        child: new Column(
                          children: <Widget>[
                            _titleFriendAcc(name, userImageUrl),
                            _listImage(imageUrl),
                            _listBottom(isLiked, postId, like),
                            _listBottomDate(time, like, title, username)
                          ],
                        ),
                      ),
                    );
                  }));
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _body() {
    return new Container(
      child: new Column(
        children: <Widget>[_listView()],
      ),
    );
  }
}
