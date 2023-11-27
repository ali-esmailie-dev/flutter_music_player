import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_music_player/core/theme/dimens.dart';
import 'package:flutter_music_player/core/widgets/buttons/app_icon_button.dart';
import 'package:flutter_music_player/core/widgets/typography/app_text.dart';
import 'package:flutter_music_player/features/home_feature/presentation/bloc/songs_cubit.dart';
import 'package:flutter_music_player/features/home_feature/presentation/widgets/album_art_widget.dart';

class SongsCard extends StatelessWidget {
  const SongsCard({super.key, required this.index});

  final int index;

  @override
  Widget build(final BuildContext context) {
    final watch = context.watch<SongsCubit>();
    return Directionality(
      textDirection: TextDirection.ltr,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: Dimens.padding,
          vertical: Dimens.smallPadding,
        ),
        onTap: () {},
        leading: AlbumArtWidget(
          albumArt: watch.state.songs[index]!.albumArt,
        ),
        title: AppText(
          watch.state.songs[index]!.trackName ?? watch.getSongName(index),
          maxLines: 1,
          textOverflow: TextOverflow.ellipsis,
        ),
        subtitle: watch.state.songs[index]?.trackArtistNames == null
            ? null
            : Container(
                margin: const EdgeInsets.only(
                  top: Dimens.padding,
                ),
                child: AppText(
                  watch.getSongArtistName(index),
                  maxLines: 1,
                  textOverflow: TextOverflow.ellipsis,
                ),
              ),
        trailing: AppIconButton(
          icon: Icons.more_vert,
          onPressed: () {},
        ),
      ),
    );
  }
}
