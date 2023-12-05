import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_music_player/core/widgets/app_divider.dart';
import 'package:flutter_music_player/core/widgets/app_loading.dart';
import 'package:flutter_music_player/core/widgets/app_scaffold.dart';
import 'package:flutter_music_player/core/widgets/general_appbar.dart';
import 'package:flutter_music_player/core/widgets/lists/app_list_view_builder.dart';
import 'package:flutter_music_player/features/home_feature/presentation/bloc/songs_cubit.dart';
import 'package:flutter_music_player/features/home_feature/presentation/widgets/songs_card.dart';

class SongsScreen extends StatefulWidget {
  const SongsScreen({super.key});

  @override
  State<SongsScreen> createState() => _SongsState();
}

class _SongsState extends State<SongsScreen> {
  @override
  Widget build(final BuildContext context) {
    final watch = context.watch<SongsCubit>();
    return BlocBuilder<SongsCubit, SongsState>(
      builder: (final context, final state) {
        return AppScaffold(
          appBar: const GeneralAppBar(
            title: 'Songs',
          ),
          smallBody: watch.state.songs.isEmpty
              ? const AppLoading()
              : AppListViewBuilder(
                  itemCount: watch.state.songs.length,
                  itemBuilder: (final context, final index) {
                    if (watch.state.songs[index] == null) {
                      return const SizedBox.shrink();
                    }
                    return SongsCard(index: index);
                  },
                  separatorBuilder: (final context, final int index) {
                    return const AppDivider(
                      height: 0,
                    );
                  },
                ),
        );
      },
    );
  }
}
