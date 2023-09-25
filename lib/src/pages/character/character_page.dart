import 'package:app_rick_and_morty_flutter/src/api/model/character.dart';
import 'package:app_rick_and_morty_flutter/src/config/typography.dart';
import 'package:app_rick_and_morty_flutter/src/pages/character/character_provider.dart';
import 'package:app_rick_and_morty_flutter/src/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CharacterPage extends ConsumerStatefulWidget {
  const CharacterPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CharacterPageState();
}

class _CharacterPageState extends ConsumerState<CharacterPage> {
  final ScrollController _scrollController = ScrollController();
  late CharacterProvider _provider;

  @override
  void initState() {
    super.initState();

    _provider = ref.read(characterProvider);

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _provider.onInit();
    });

    _scrollController.addListener(onEndReached);
  }

  @override
  void dispose() {
    super.dispose();

    _provider.dispose();
    _scrollController.removeListener(onEndReached);
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final status = ref.watch(characterProvider);

    if (status.isInitialLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return _CharacterList(
      characters: status.characters,
      isLoading: status.isMoreLoadingVisible,
      hasMoreElements: status.hasMoreCharacters,
      controller: _scrollController,
    );
  }

  void onEndReached() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _provider.fetchMoreCharacters();
    }
  }
}

class _CharacterList extends StatelessWidget {
  const _CharacterList({
    required this.characters,
    required this.controller,
    required this.isLoading,
    required this.hasMoreElements,
  });

  final List<Character> characters;
  final bool isLoading;
  final bool hasMoreElements;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    if (characters.isEmpty) {
      return const Center(child: Text("No hay elementos"));
    }

    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16, top: 16),
      child: ListView.builder(
        controller: controller,
        itemCount: characters.length + 1,
        itemBuilder: (_, index) {
          if (index < characters.length) {
            final character = characters[index];

            return _CharacterItem(character: character);
          } else {
            return Footer(
              isLoadingVisible: isLoading,
              hasMoreElements: hasMoreElements,
            );
          }
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
