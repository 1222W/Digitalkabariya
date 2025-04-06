import 'package:flutter/widgets.dart';

extension SizedBoxExtension on num {
  SizedBox get sizedBoxHeight => SizedBox(
        height: toDouble(),
      );
  SizedBox get sizedBoxWidth => SizedBox(
        width: toDouble(),
      );
}
