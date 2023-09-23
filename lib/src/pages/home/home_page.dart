import 'dart:io';

import 'package:app_rick_and_morty_flutter/src/pages/character/character_page.dart';
import 'package:app_rick_and_morty_flutter/src/pages/episodes/episodes_page.dart';
import 'package:app_rick_and_morty_flutter/src/pages/home/home_provider.dart';
import 'package:app_rick_and_morty_flutter/src/pages/locations/locations_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int position = ref.watch(homeProvider).tabPosition;
    Function(int) onItemTapped = ref.read(homeProvider).onItemTapped;

    return Scaffold(
      body: Center(child: _widgetOptions.elementAt(position)),
      bottomNavigationBar: _BottomNavigation(
        position: position,
        onItemTapped: onItemTapped,
      ),
    );
  }

  static const List<Widget> _widgetOptions = <Widget>[
    CharacterPage(),
    LocationsPage(),
    EpisodesPage(),
  ];
}

class _BottomNavigation extends StatelessWidget {
  _BottomNavigation({required this.position, required this.onItemTapped});

  final int position;
  final Function(int) onItemTapped;

  final Map<String, Icon> _navigationItems = {
    'Characters': const Icon(Icons.person),
    'Locations': const Icon(Icons.location_city),
    'Episodes': const Icon(Icons.movie),
  };

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoTabBar(
            currentIndex: position,
            onTap: onItemTapped,
            items: _navigationItems.entries
                .map<BottomNavigationBarItem>(
                    (entry) => BottomNavigationBarItem(
                          icon: entry.value,
                          label: entry.key,
                        ))
                .toList(),
          )
        : NavigationBar(
            selectedIndex: position,
            onDestinationSelected: onItemTapped,
            destinations: _navigationItems.entries
                .map<Widget>((entry) => NavigationDestination(
                      icon: entry.value,
                      label: entry.key,
                    ))
                .toList(),
          );
  }
}
