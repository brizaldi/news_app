import 'package:flutter/material.dart';

import 'filter_section.dart';
import 'list_section.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: const [
          FilterSection(),
          SizedBox(height: 16),
          Expanded(child: ListSection()),
        ],
      ),
    );
  }
}
