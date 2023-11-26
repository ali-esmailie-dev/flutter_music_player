import 'package:flutter/material.dart';
import 'package:flutter_music_player/core/theme/dimens.dart';
import 'package:flutter_music_player/core/utils/sized_context.dart';

bool checkDesktopSize(final BuildContext context) {
  return context.sizePx.width > Dimens.largeDeviceBreakPoint;
}
