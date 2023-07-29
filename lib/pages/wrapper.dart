import 'package:brew_maate/models/user_custom.dart';
import 'package:brew_maate/pages/authenticate/authenticate.dart';
import 'package:brew_maate/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserCustom?>(context);

    //return Home or Authenticate Widget
    return (user == null) ? const Authenticate() : Home();
  }
}
