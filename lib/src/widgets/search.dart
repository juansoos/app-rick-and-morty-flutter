import 'package:app_rick_and_morty_flutter/src/config/colors.dart';
import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search(
      {super.key, required this.controller, required this.onChangeText});

  final TextEditingController controller;
  final Function(String) onChangeText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Search',
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () => controller.clear(),
          ),
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: CustomColors.primary300, width: 1),
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        onChanged: (value) {
          onChangeText(value);
        },
      ),
    );
  }
}
