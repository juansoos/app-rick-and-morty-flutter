import 'package:app_rick_and_morty_flutter/src/pages/home/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int postion = ref.watch(homeProvider).tabPosition;

    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(postion),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: postion,
        onTap: ref.read(homeProvider).onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Characters',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_city),
            label: 'Locations',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Episodes',
          ),
        ],
      ),
    );
  }

  static const List<Widget> _widgetOptions = <Widget>[
    Text('Characters'),
    Text('Locations'),
    Text('Episodes'),
  ];
}
