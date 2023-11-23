import 'package:flutter/material.dart';
import 'package:user_app/mainscreens/home.dart';

import 'package:user_app/mainscreens/profile.dart';

class mainpage extends StatefulWidget {
  const mainpage({super.key});

  @override
  State<mainpage> createState() => _mainpageState();
}

class _mainpageState extends State<mainpage> {
  final _pages = [
    home(),
    profile(),
  ];
  int indexnum = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("welcome"),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
            // BottomNavigationBarItem(icon: Icon(Icons.money), label: "Earnings")
          ],
          unselectedItemColor: Color.fromARGB(255, 214, 135, 227),
          iconSize: 15,
          selectedFontSize: 18,
          currentIndex: indexnum,
          onTap: (int index) {
            setState(() {
              indexnum = index;
            });
          },
        ),
      ),
      body: _pages[indexnum],
    );
  }
}
