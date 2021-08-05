import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../extra/style/style.dart';

class LoadMoreIndicator extends StatelessWidget {
  const LoadMoreIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SpinKitCircle(
      color: Palette.amaranth,
    );
  }
}
