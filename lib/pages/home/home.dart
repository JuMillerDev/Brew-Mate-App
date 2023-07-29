import 'package:brew_maate/pages/home/settings_form.dart';
import 'package:brew_maate/services/auth.dart';
import 'package:brew_maate/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_maate/models/brew.dart';
import 'package:brew_maate/pages/home/brew_list.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          backgroundColor: Colors.brown[50],
          context: context,
          builder: (context) {
            return const SettingsForm();
          });
    }

    return StreamProvider<List<Brew>?>.value(
      value: DatabaseService.withoutUID().brews,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: const Text('Brew Mate'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: [
            IconButton(
                onPressed: () async {
                  await auth.signOut();
                },
                icon: const Icon(Icons.logout)),
            TextButton.icon(
              style: const ButtonStyle(
                  foregroundColor: MaterialStatePropertyAll(Colors.white)),
              onPressed: () => _showSettingsPanel(),
              icon: const Icon(Icons.settings),
              label: const Text('Settings'),
            )
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/coffee_bg.png'),
            fit: BoxFit.cover,
          )),
          child: const BrewList(),
        ),
      ),
    );
  }
}
