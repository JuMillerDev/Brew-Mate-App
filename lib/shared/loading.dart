import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown,
      child: const Center(
        child: SpinKitFoldingCube(
          size: 60.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
