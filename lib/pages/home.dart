import 'package:flutter/material.dart';
import 'package:tikkeul/pages/account_book.dart';
import 'package:tikkeul/pages/settings.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _selectedIndex = 0;
  var _pages = [
    AccountBook(),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
              label: '가계부',
              icon: Icon(
                Icons.auto_stories_outlined,
              )),
          BottomNavigationBarItem(
            label: '설정',
            icon: Icon(
              Icons.settings,
            ),
          ),
        ],
      ),
    );
  }
}
