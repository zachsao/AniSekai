import 'dart:core';

import 'package:anisekai/details/anime_details_view.dart';
import 'package:anisekai/favourites/favourites_view.dart';
import 'package:anisekai/graphql/client_provider.dart';
import 'package:anisekai/home/home_view.dart';
import 'package:anisekai/profile/profile_view.dart';
import 'package:anisekai/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import 'discover/discover_view.dart';

void main() async {
  await initHiveForFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthenticationState(),
      child: ClientProvider(
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => const SplashPage(),
            DetailsPage.routeName: (context) => const DetailsPage(),
          },
        ),
      ),
    );
  }
}

class LoggedInPage extends StatefulWidget {
  const LoggedInPage({Key? key, required this.userId}) : super(key: key);
  final int userId;

  @override
  State<LoggedInPage> createState() => _LoggedInPageState();
}

class _LoggedInPageState extends State<LoggedInPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> bottomNavItems = [
      const BottomNavigationBarItem(
          icon: Icon(Icons.home_filled), label: "Home"),
      const BottomNavigationBarItem(
          icon: Icon(Icons.explore), label: "Discover"),
      const BottomNavigationBarItem(
          icon: Icon(Icons.favorite), label: "Favorites"),
      const BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
    ];

    List<Widget> pages = [
      HomePage(userId: widget.userId),
      const DiscoverPage(),
      const FavouritesPage(),
      const ProfilePage()
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavItems,
        selectedItemColor: ThemeData.light().primaryColor,
        unselectedItemColor: Colors.grey,
        backgroundColor: const Color(0xFF2B2D42),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
      body: _selectedIndex == 0
          ? HomePage(userId: widget.userId)
          : Scaffold(
              appBar: AppBar(
                toolbarHeight: 70,
                title: Text(
                  bottomNavItems[_selectedIndex].label ?? "",
                  style: const TextStyle(
                      fontSize: 36.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              body: pages[_selectedIndex],
            ),
    );
  }
}
