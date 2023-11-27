import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_music_player/core/theme/dimens.dart';
import 'package:flutter_music_player/core/utils/get_primary_color.dart';

class AlbumArtWidget extends StatelessWidget {
  const AlbumArtWidget({super.key, this.albumArt});

  final Uint8List? albumArt;

  @override
  Widget build(final BuildContext context) {
    try {
      return ClipRRect(
        borderRadius: BorderRadius.circular(Dimens.base),
        child: Image.memory(
          albumArt!,
          height: 50.0,
          width: 50.0,
          errorBuilder: (final context, final error, final stackTrace) {
            return const AlbumArtPlaceholder();
          },
        ),
      );
    } catch (e) {
      return const AlbumArtPlaceholder();
    }
  }
}

class AlbumArtPlaceholder extends StatelessWidget {
  const AlbumArtPlaceholder({super.key});

  @override
  Widget build(final BuildContext context) {
    return Opacity(
      opacity: 0.8,
      child: Container(
        height: 50.0,
        width: 50.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimens.corners),
          color: getPrimaryColor(context),
        ),
        child: const Icon(
          Icons.music_note_outlined,
          size: 25,
          color: Colors.white,
        ),
      ),
    );
  }
}
