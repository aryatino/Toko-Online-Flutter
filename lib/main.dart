import 'package:flutter/material.dart';
import 'package:mysample/pages/login_screen.dart';
import 'package:mysample/pages/register_screen.dart';

import 'pages/feeds_screen.dart';
import 'pages/home_screen.dart';
import 'pages/mall_screen.dart';
import 'pages/profile_screen.dart';
import 'pages/transaction_screen.dart';

/// Flutter code sample for [NavigationBar].

void main() => runApp(const NavigationBarApp());

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       initialRoute: '/login',

            // Daftar Route
      routes: {
        '/login'   : (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const NavigationExample(),
      },
    );
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        child: NavigationBar(
          // ketika menu di klik
          onDestinationSelected: (int selectedMenu) {
            setState(() {
              currentPageIndex = selectedMenu;
            });
          },
          indicatorColor: Theme.of(context).colorScheme.primary,
          // menunjukkan menu mana yan aktif
          selectedIndex: currentPageIndex,
          // kumpulan menu
          destinations: const <Widget>[
            // menu-menu di bagian bawah halaman
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.video_collection),
              icon: Icon(Icons.home_outlined),
              label: 'Feeds',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.store),
              icon: Icon(Icons.home_outlined),
              label: 'Mall',
            ),
            NavigationDestination(
              icon: Badge(child: Icon(Icons.list_alt_outlined)),
              label: 'Transactions',
            ),
            NavigationDestination(
              icon: Badge(label: Text('2'), child: Icon(Icons.person)),
              label: 'Profile',
            ),
          ],
        ),
      ),
      body: <Widget>[
        HomeScreen(),
        FeedsScreen(),
        MallScreen(),
        TransactionScreen(),
        ProfileScreen(),
      ][currentPageIndex],
    );
  }
}
