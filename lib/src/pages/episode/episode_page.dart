import 'package:app_rick_and_morty_flutter/src/api/model/episode.dart';
import 'package:app_rick_and_morty_flutter/src/config/typography.dart';
import 'package:app_rick_and_morty_flutter/src/pages/episode/episode_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EpisodePage extends ConsumerStatefulWidget {
  const EpisodePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EpisodePageState();
}

class _EpisodePageState extends ConsumerState<EpisodePage> {
  final ScrollController _scrollController = ScrollController();
  late EpisodeProvider _provider;

  @override
  void initState() {
    super.initState();

    _provider = ref.read(episodeProvider);

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
    final status = ref.watch(episodeProvider);

    if (status.isInitialLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return _EpisodeList(
      episodes: status.episodes,
      isLoading: status.isMoreLoadingVisible,
      controller: _scrollController,
    );
  }

  void onEndReached() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _provider.fetchMoreEpisodes();
    }
  }
}

class _EpisodeList extends StatelessWidget {
  const _EpisodeList({
    required this.episodes,
    required this.controller,
    required this.isLoading,
  });

  final List<Episode> episodes;
  final bool isLoading;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    if (episodes.isEmpty) {
      return const Center(child: Text("No hay elementos"));
    }

    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16, top: 16),
      child: ListView.builder(
        controller: controller,
        itemCount: episodes.length + 1,
        itemBuilder: (_, index) {
          if (index < episodes.length) {
            final episode = episodes[index];

            return _EpisodeItem(episode: episode);
          } else {
            return isLoading
                ? Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(16.0),
                    child: const CircularProgressIndicator(),
                  )
                : const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class _EpisodeItem extends StatelessWidget {
  const _EpisodeItem({required this.episode});

  final Episode episode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            episode.name!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: CustomTypography.title1,
          ),
          Text(episode.episode!, style: CustomTypography.body1),
          Text(episode.airDate!, style: CustomTypography.caption1),
        ],
      ),
    );
  }
}
