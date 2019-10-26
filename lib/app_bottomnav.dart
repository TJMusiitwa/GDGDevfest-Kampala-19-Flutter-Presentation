import 'package:flutter/material.dart';
import 'package:gdg_devfest_flutter/local_list.dart';
import 'package:gdg_devfest_flutter/web_list.dart';

class NetworkNav extends StatefulWidget {
  @override
  _NetworkNavState createState() => _NetworkNavState();
}

class _NetworkNavState extends State<NetworkNav> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: <Widget>[WebList(), LocalList()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (val) {
          setState(() {
            _currentIndex = val;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.web), title: Text('Web Recipes')),
          BottomNavigationBarItem(
              icon: Icon(Icons.code), title: Text('Local JSON'))
        ],
      ),
    );
  }
}
