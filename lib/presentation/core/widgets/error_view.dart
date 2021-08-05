import 'package:flutter/material.dart';

import '../../../extra/style/style.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({
    Key? key,
    required this.message,
    required this.onRetry,
  }) : super(key: key);

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message),
          const SizedBox(height: 16),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Palette.amaranth,
            ),
            onPressed: onRetry,
            child: const Text(
              'Retry',
            ),
          ),
        ],
      ),
    );
  }
}
