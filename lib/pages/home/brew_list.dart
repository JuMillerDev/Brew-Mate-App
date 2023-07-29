import 'package:brew_maate/models/brew.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_maate/pages/home/brew_tile.dart';

class BrewList extends StatefulWidget {
  const BrewList({super.key});

  @override
  State<BrewList> createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>?>(context) ?? [];
    for (var element in brews) {
      print(element.name);
      print(element.sugar);
      print(element.strength);
    }

    return ListView.builder(
      itemCount: brews.length,
      itemBuilder: (context, index) {
        return BrewTile(brew: brews[index]);
      },
    );
  }
}
