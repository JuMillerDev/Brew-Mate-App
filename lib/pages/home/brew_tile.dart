import 'package:flutter/material.dart';
import 'package:brew_maate/models/brew.dart';

class BrewTile extends StatelessWidget {
  const BrewTile({super.key, this.brew});

  final Brew? brew;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.brown[brew!.strength],
            backgroundImage: const AssetImage('assets/coffee_icon.png'),
            radius: 25.0,
          ),
          title: Text(brew!.name),
          subtitle: Text('Takes ${brew!.sugar} sugar(s)'),
        ),
      ),
    );
  }
}
