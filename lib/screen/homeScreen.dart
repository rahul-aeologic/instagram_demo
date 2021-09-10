import 'package:flutter/material.dart';
import 'package:instagram_demo/screen/bottomIconScreen/accountBottomIconScreen.dart';
import 'package:instagram_demo/screen/bottomIconScreen/homeBottomIconScreen.dart';
import 'package:instagram_demo/screen/bottomIconScreen/likeBottomIconScreen.dart';
import 'package:instagram_demo/screen/bottomIconScreen/plusBottomIconScreen.dart';
import 'package:instagram_demo/screen/bottomIconScreen/searchBottomIconScreen.dart';

class HomeScreen extends StatefulWidget {
  String username;
  String name;
  String profileUrl;
  HomeScreen(@required this.username, this.name, this.profileUrl);

  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _currentTab = 0;

  late List<Widget> page;
  var _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPage = new HomeBottomIconScreen();

    page = [
      new HomeBottomIconScreen(),
      new SearchBottomIconScreen(),
      new PlusBottomIconScreen(),
      new LikeBottomIconScreen(),
      new AccountBottomIconScreen(widget.name, widget.name, widget.profileUrl),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var _bottomItems = new BottomNavigationBar(
      currentIndex: _currentTab,
      onTap: (int index) {
        setState(() {
          _currentTab = index;
          _currentPage = page[index];
        });
      },
      type: BottomNavigationBarType.fixed,
      iconSize: 30.0,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: Colors.grey,
          ),
          label: 'Home',
          activeIcon: Icon(
            Icons.home,
            color: Colors.black,
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.search,
            color: Colors.grey,
          ),
          activeIcon: Icon(
            Icons.search,
            color: Colors.black,
          ),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.add_box,
            color: Colors.grey,
          ),
          activeIcon: Icon(
            Icons.add_box,
            color: Colors.black,
          ),
          label: 'Add',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.favorite,
            color: Colors.grey,
          ),
          activeIcon: Icon(
            Icons.favorite,
            color: Colors.black,
          ),
          label: 'Fav',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.account_circle,
            color: Colors.grey,
          ),
          activeIcon: Icon(
            Icons.account_circle,
            color: Colors.black,
          ),
          label: 'Account',
        ),
      ],
    );

    return new Scaffold(bottomNavigationBar: _bottomItems, body: _currentPage);
  }
}
