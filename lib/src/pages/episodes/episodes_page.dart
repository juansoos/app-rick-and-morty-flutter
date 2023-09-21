import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EpisodesPage extends ConsumerStatefulWidget {
  const EpisodesPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EpisodesPageState();
}

class _EpisodesPageState extends ConsumerState<EpisodesPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Episodes Page'),
    );
  }
}
