import 'package:app_rick_and_morty_flutter/src/api/model/location.dart';
import 'package:app_rick_and_morty_flutter/src/config/typography.dart';
import 'package:app_rick_and_morty_flutter/src/pages/location/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocationPage extends ConsumerStatefulWidget {
  const LocationPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LocationPageState();
}

class _LocationPageState extends ConsumerState<LocationPage> {
  final ScrollController _scrollController = ScrollController();
  late LocationProvider _provider;

  @override
  void initState() {
    super.initState();

    _provider = ref.read(locationProvider);

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
    final status = ref.watch(locationProvider);

    if (status.isInitialLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return _LocationList(
      locations: status.locations,
      isLoading: status.isMoreLoadingVisible,
      controller: _scrollController,
    );
  }

  void onEndReached() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _provider.fetchMoreLocations();
    }
  }
}

class _LocationList extends StatelessWidget {
  const _LocationList({
    required this.locations,
    required this.controller,
    required this.isLoading,
  });

  final List<Location> locations;
  final bool isLoading;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    if (locations.isEmpty) {
      return const Center(child: Text("No hay elementos"));
    }

    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16, top: 16),
      child: ListView.builder(
        controller: controller,
        itemCount: locations.length + 1,
        itemBuilder: (_, index) {
          if (index < locations.length) {
            final location = locations[index];

            return _LocationItem(location: location);
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

class _LocationItem extends StatelessWidget {
  const _LocationItem({required this.location});

  final Location location;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            location.name!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: CustomTypography.title1,
          ),
          Text(location.dimension!, style: CustomTypography.body1),
          Text(location.type!, style: CustomTypography.caption1),
        ],
      ),
    );
  }
}
