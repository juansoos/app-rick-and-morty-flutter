import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({
    super.key,
    required this.isLoadingVisible,
    required this.hasMoreElements,
  });

  final bool isLoadingVisible;
  final bool hasMoreElements;

  @override
  Widget build(BuildContext context) {
    if (isLoadingVisible) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16.0),
        child: const CircularProgressIndicator(),
      );
    }

    if (!hasMoreElements) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16.0),
        child: const Text("No hay más elementos"),
      );
    }

    return const SizedBox.shrink();
  }
}
