import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CharactersPage extends ConsumerStatefulWidget {
  const CharactersPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CharactersPageState();
}

class _CharactersPageState extends ConsumerState<CharactersPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Characters Page'),
    );
  }
}
