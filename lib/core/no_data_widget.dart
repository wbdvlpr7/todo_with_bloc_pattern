import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Opacity(
        opacity: 0.2,
        child: Text('There is no data to show!'),
      ),
    );
  }
}
