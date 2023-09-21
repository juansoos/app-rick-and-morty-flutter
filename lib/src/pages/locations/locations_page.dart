import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocationsPage extends ConsumerStatefulWidget {
  const LocationsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LocationsPageState();
}

class _LocationsPageState extends ConsumerState<LocationsPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Locations Page'),
    );
  }
}
