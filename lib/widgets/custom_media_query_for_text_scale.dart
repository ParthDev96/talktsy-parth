import 'package:flutter/material.dart';

class CustomMediaTextScale extends StatelessWidget {
  final Widget? child;
  const CustomMediaTextScale({super.key,this.child});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0), child: child!,
    );
  }
}
