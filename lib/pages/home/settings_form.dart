import 'package:brew_maate/models/user_custom.dart';
import 'package:brew_maate/services/database.dart';
import 'package:flutter/material.dart';
import 'package:brew_maate/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugar = ['0', '1', '2', '3', '4'];

  String? _currentName;
  String? _currentSugar;
  int? _currentStrength;

  //stream builder is best when you only have to use the stream in this file
  //so that you don`t have to put streambuilders just to pass data to another streambuilder in future

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserCustom?>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user!.uid).user_data,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;

            return Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15.0,
                    ),
                    const Text(
                      'Update your brew settings.',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Current name: ${userData!.name}'),
                        initialValue: userData.name,
                        validator: (value) =>
                            value!.isEmpty ? 'Please provide a name' : null,
                        onChanged: (value) => _currentName = value),
                    const SizedBox(
                      height: 20.0,
                    ),
                    //dropdown
                    DropdownButtonFormField(
                      decoration: textInputDecoration,
                      hint: Text('Current sugar(s): ${userData.sugar}'),
                      value: _currentSugar ?? userData.sugar,
                      items: sugar
                          .map((sugar) => DropdownMenuItem(
                              value: sugar, child: Text('$sugar sugars')))
                          .toList(),
                      onChanged: (e) => _currentSugar = e!,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text(
                      'Brew Strength.',
                      style: TextStyle(fontSize: 15.0),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    //slider
                    Slider(
                      min: 100,
                      max: 900,
                      divisions: 8,
                      activeColor:
                          Colors.brown[_currentStrength ?? userData.strength],
                      inactiveColor:
                          Colors.brown[_currentStrength ?? userData.strength],
                      value: _currentStrength?.toDouble() ??
                          userData.strength.toDouble(),
                      onChanged: (e) => setState(() {
                        _currentStrength = e.round();
                      }),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    //approve button
                    ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.pink)),
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          await DatabaseService(uid: userData.uid)
                              .updateUserData(
                                  _currentSugar ?? userData.sugar,
                                  _currentName ?? userData.name,
                                  _currentStrength ?? userData.strength);
                          if (context.mounted) Navigator.pop(context);
                        }
                        print('Brew name: $_currentName');
                        print('sugar: $_currentSugar');
                        print('strength: $_currentStrength');
                      },
                      child: const Text('Update'),
                    )
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
