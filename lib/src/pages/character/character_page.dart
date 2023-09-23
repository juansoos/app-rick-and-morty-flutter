import 'package:app_rick_and_morty_flutter/src/api/model/character.dart';
import 'package:app_rick_and_morty_flutter/src/config/typography.dart';
import 'package:app_rick_and_morty_flutter/src/pages/character/character_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CharacterPage extends ConsumerStatefulWidget {
  const CharacterPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CharacterPageState();
}

class _CharacterPageState extends ConsumerState<CharacterPage> {
  @override
  void initState() {
    super.initState();

    final repository = ref.read(characterProvider);

    SchedulerBinding.instance.addPostFrameCallback((_) {
      repository.onInit();
    });
  }

  @override
  Widget build(BuildContext context) {
    final status = ref.watch(characterProvider);

    return status.isInitialLoading
        ? const Center(child: CircularProgressIndicator())
        : status.characters!.isNotEmpty
            ? _CharacterList(characters: status.characters!)
            : const Center(child: Text("No hay elementos"));
  }
}

class _CharacterList extends StatelessWidget {
  const _CharacterList({required this.characters});

  final List<Character> characters;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16, top: 16),
      child: ListView.builder(
        itemCount: characters.length,
        itemBuilder: (_, index) {
          final character = characters[index];

          return _CharacterItem(character: character);
        },
      ),
    );
  }
}

class _CharacterItem extends StatelessWidget {
  const _CharacterItem({required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(character.image!, height: 150, width: 150),
          ),
          const SizedBox(width: 40),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  character.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: CustomTypography.title1,
                ),
                Text(character.gender!, style: CustomTypography.body1),
                Text(character.species!, style: CustomTypography.caption1),
              ],
            ),
          )
        ],
      ),
    );
  }
}
