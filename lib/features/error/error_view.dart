import 'package:bekia_pay/core/utils/extensions/widget_extensions.dart';
import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(title: const Text('Error'), centerTitle: true),
      body: Text('Something went wrong').center,
    );
  }
}
