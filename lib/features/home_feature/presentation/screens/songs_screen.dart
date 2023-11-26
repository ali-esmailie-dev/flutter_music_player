import 'package:flutter/material.dart';
import 'package:flutter_music_player/core/widgets/app_scaffold.dart';
import 'package:flutter_music_player/core/widgets/general_appbar.dart';
import 'package:flutter_music_player/core/widgets/lists/app_list_view_builder.dart';

class Songs extends StatelessWidget {
  const Songs({super.key});

  @override
  Widget build(final BuildContext context) {
    return const AppScaffold(
      appBar: GeneralAppBar(
        title: 'Songs',
      ),
      // smallBody: AppListViewBuilder(
      //
      // ),
    );
  }
}
