import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:animestation_project_uas/Screen/category.dart';
import 'package:animestation_project_uas/Screen/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:animestation_project_uas/Screen/history.dart';
import 'package:animestation_project_uas/Screen/profile.dart';
import 'package:animestation_project_uas/main.dart';
import 'package:animestation_project_uas/Screen/populers.dart';
import 'package:animestation_project_uas/Screen/setting.dart';
import 'package:animestation_project_uas/Screen/welcome_screen.dart';

void main() {
  runApp(const MyApp ());
}

class NavBar extends StatelessWidget {
  const NavBar ({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _currentIndex = 0;
 final PageController _pageController = PageController();

@override
  void dispose() {
  _pageController.dispose();
  super.dispose();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            Dashboard(),
            Category(),
            WatchHistoryScreen(),
            Profile(),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: [
          BottomNavyBarItem(
            icon: const Icon(Icons.home),
            title: const Text('Home'),
            activeColor: const Color.fromARGB(255, 0, 0, 0),
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.search),
            title: const Text('Category'),
            activeColor: const Color.fromARGB(255, 0, 0, 0),
          ),
          BottomNavyBarItem(
              icon: const Icon(Icons.history),
              title: const Text('History'),
              activeColor: const Color.fromARGB(255, 0, 0, 0)
          ),
          BottomNavyBarItem(
              icon: const Icon(Icons.person),
              title: const Text('Profile'),
              activeColor: const Color.fromARGB(255, 0, 0, 0)
          ),
        ],
      ),
    );
  }
}