import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_music_player/core/utils/app_permissions_helper.dart';
import 'package:flutter_music_player/core/widgets/app_scaffold.dart';
import 'package:flutter_music_player/core/widgets/buttons/app_button.dart';
import 'package:flutter_music_player/core/widgets/general_appbar.dart';
import 'package:flutter_music_player/core/widgets/lists/app_list_view.dart';
import 'package:flutter_music_player/features/home_feature/presentation/screens/animation_demo_screens/fade_scale_transition_demo.dart';
import 'package:flutter_music_player/features/home_feature/presentation/screens/animation_demo_screens/fade_through_transition_demo.dart';
import 'package:flutter_music_player/features/home_feature/presentation/screens/animation_demo_screens/open_container_transform_demo.dart';
import 'package:flutter_music_player/features/home_feature/presentation/screens/animation_demo_screens/shared_axis_transition_demo.dart';
import 'package:flutter_music_player/features/home_feature/presentation/screens/animation_demo_screens/slide_transition_demo.dart';
import 'package:permission_handler/permission_handler.dart';

class PlayGround extends StatefulWidget {
  const PlayGround({super.key});

  @override
  State<PlayGround> createState() => _PlayGroundState();
}

class _PlayGroundState extends State<PlayGround> {
  final List<FileSystemEntity> songs = [];

  void getSongs() {
    AppPermissionHelper.checkPermissionStatus(Permission.storage)
        .then((final bool hasPermission) async {
      if (hasPermission) {
        songs.clear();
        final Directory directory = Directory('/storage/emulated/0/');

        final List<FileSystemEntity> entities = directory.listSync().toList();

        findSongs(entities);

        print(songs.length);
        final stat = FileStat.statSync(songs.first.path);
        print('Accessed: ${stat.accessed}');
        print('Modified: ${stat.modified}');
        print('Changed: ${stat.changed}');
        print('size:  ${stat.size}');
      } else {
        AppPermissionHelper.requestPermission(Permission.storage).then((
          final value,
        ) {
          getSongs();
        });
      }
    });
  }

  void findSongs(
    final List<FileSystemEntity> entities,
  ) {
    for (final FileSystemEntity directoryEntity in entities) {
      if (!checkDirectoryType(directoryEntity)) {
        checkAndAddSong(directoryEntity);
      } else {
        if (checkDirectoryType(directoryEntity)) {
          if (!checkAndroidDirectory(directoryEntity)) {
            final Directory directory = Directory(directoryEntity.path);
            final List<FileSystemEntity> entities =
                directory.listSync(recursive: true).toList();
            for (final FileSystemEntity directoryEntity in entities) {
              if (!checkDirectoryType(directoryEntity)) {
                checkAndAddSong(directoryEntity);
              } else {
                continue;
              }
            }
          }
        }
      }
    }
  }

  bool checkDirectoryType(final FileSystemEntity directoryEntity) {
    return directoryEntity is Directory;
  }

  bool checkAndroidDirectory(final FileSystemEntity directoryEntity) {
    return directoryEntity.toString().toLowerCase().contains('android');
  }

  void checkAndAddSong(final FileSystemEntity directoryEntity) {
    if (directoryEntity.path.toLowerCase().contains('.mp3')) {
      songs.add(directoryEntity);
    }
  }

  @override
  Widget build(final BuildContext context) {
    return AppScaffold(
      appBar: const GeneralAppBar(
        title: 'Play ground',
      ),
      smallBody: AppListView(
        children: [
          AppButton(
            title: 'Open Container Transform Demo',
            onPressed: () {
              _appNavigator(const OpenContainerTransformDemo());
            },
          ),
          AppButton(
            title: 'Shared Axis Transition Demo',
            onPressed: () {
              _appNavigator(const SharedAxisTransitionDemo());
            },
          ),
          AppButton(
            title: 'Fade Scale Transition Demo',
            onPressed: () {
              _appNavigator(const FadeScaleTransitionDemo());
            },
          ),
          AppButton(
            title: 'Fade Through Transition Demo',
            onPressed: () {
              _appNavigator(const FadeThroughTransitionDemo());
            },
          ),
          AppButton(
            title: 'Slide Transition Demo',
            onPressed: () {
              _appNavigator(const SlideTransitionDemo());
            },
          ),
          AppButton(
            title: 'get songs',
            onPressed: () {
              getSongs();
            },
          ),
        ],
      ),
    );
  }

  void _appNavigator(
    final Widget page,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (final context) => page),
    );
  }
}
