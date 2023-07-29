import 'package:brew_maate/services/auth.dart';
import 'package:brew_maate/shared/constants.dart';
import 'package:brew_maate/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({super.key, required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //text field state
  String _email = '';
  String _password = '';
  String _error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: const Text('Sign In To Brew Buddy'),
              actions: [
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextButton.icon(
                    style: const ButtonStyle(
                        foregroundColor:
                            MaterialStatePropertyAll(Colors.white)),
                    onPressed: () {
                      widget.toggleView();
                    },
                    label: const Text(
                      'Register',
                      textAlign: TextAlign.left,
                    ),
                    icon: const Icon(Icons.person),
                  ),
                )
              ],
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Email'),
                        validator: (val) =>
                            val!.isEmpty ? 'Enter an email' : null,
                        onChanged: (value) {
                          _email = value;
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Password'),
                        obscureText: true,
                        validator: (val) => val!.length < 6
                            ? 'Enter a password 6+ chars long'
                            : null,
                        onChanged: (value) {
                          _password = value;
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.pink[400])),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() => loading = true);
                            dynamic result =
                                await _auth.signInWithEmail(_email, _password);
                            result == null
                                ? setState(
                                    () {
                                      _error =
                                          'please supply a valid email or password';
                                      loading = false;
                                    },
                                  )
                                : null;
                          }
                        },
                        child: const Text(
                          'Sign In',
                        ),
                      ),
                      Text(
                        _error,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  )),
            ),
          );
  }
}
