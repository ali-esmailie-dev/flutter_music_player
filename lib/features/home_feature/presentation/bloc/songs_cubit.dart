import 'dart:io';

import 'package:audiotags/audiotags.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:flutter_music_player/core/localization/i18n/translations.g.dart';
import 'package:flutter_music_player/core/utils/app_permissions_helper.dart';
import 'package:flutter_music_player/core/utils/app_snack_bar.dart';
import 'package:flutter_music_player/features/home_feature/data/data_sources/models/song_model.dart';
import 'package:permission_handler/permission_handler.dart';

part 'songs_state.dart';

class SongsCubit extends Cubit<SongsState> {
  SongsCubit() : super(SongsState(songs: []));

  static List<SongModel?> songsEntity = [];

  Future<bool> checkMediaPermission() {
    return AppPermissionHelper.checkPermissionStatus(Permission.storage);
  }

  Future<bool> requestPermission() async {
    if (await Permission.storage.isPermanentlyDenied) {
      await openAppSettings();
      return false;
    }
    return AppPermissionHelper.requestPermission(Permission.storage);
  }

  Future<void> getSongs() async {
    try {
      emit(state.copyWith(loading: true));

      final Directory directory = Directory('/storage/emulated/0/');
      final List<FileSystemEntity> entities = directory.listSync().toList();

      songsEntity = await compute(findSongs, entities);

      print(songsEntity.length);

      emit(state.copyWith(songs: songsEntity));
    } catch (e) {
      showSnackBar(t.throwException);
    }
  }

  static Future<List<SongModel?>> findSongs(
    final List<FileSystemEntity> entities,
  ) async {
    for (final FileSystemEntity directoryEntity in entities) {
      if (!checkDirectoryType(directoryEntity)) {
        await checkAndAddSong(directoryEntity);
      } else {
        if (checkDirectoryType(directoryEntity)) {
          if (!checkAndroidDirectory(directoryEntity)) {
            final Directory directory = Directory(directoryEntity.path);
            final List<FileSystemEntity> entities =
                directory.listSync(recursive: true).toList();
            for (final FileSystemEntity directoryEntity in entities) {
              if (!checkDirectoryType(directoryEntity)) {
                await checkAndAddSong(directoryEntity);
              } else {
                continue;
              }
            }
          }
        }
      }
    }
    return songsEntity;
  }

  static bool checkDirectoryType(final FileSystemEntity directoryEntity) {
    return directoryEntity is Directory;
  }

  static bool checkAndroidDirectory(final FileSystemEntity directoryEntity) {
    return directoryEntity.toString().toLowerCase().contains('android');
  }

  static Future<void> checkAndAddSong(
    final FileSystemEntity directoryEntity,
  ) async {
    if (directoryEntity.path.toLowerCase().contains('.mp3')) {
      try {
        final Tag? metaData = await AudioTags.read(directoryEntity.path);

        if (metaData != null) {
          songsEntity.add(
            SongModel(
              trackArtistNames: [metaData.trackArtist ?? ''],
              filePath: directoryEntity.path,
              trackDuration: metaData.duration,
              albumArt: metaData.pictures.first.bytes,
              genre: metaData.genre,
              year: metaData.year,
              trackNumber: metaData.trackNumber,
              discNumber: metaData.discNumber,
              albumArtistName: metaData.albumArtist,
              trackName: metaData.title,
            ),
          );
        }
      } catch (e) {
        return;
      }
    }
  }

  Future<Metadata?> getSongMetadata(
    final FileSystemEntity directoryEntity,
  ) async {
    try {
      final Metadata metadata = await MetadataRetriever.fromFile(
        File(directoryEntity.path),
      );
      return metadata;
    } catch (e) {
      return null;
    }
  }

  String getSongName(final int index) {
    try {
      if (state.songs[index]!.trackName == null ||
          state.songs[index]!.trackName == '') {
        return state.songs[index]!.filePath!.split('/').last.replaceAll(
              '.mp3',
              '',
            );
      } else {
        return state.songs[index]!.trackName!;
      }
    } catch (e) {
      return '';
    }
  }

  String getSongArtistName(final int index) {
    try {
      if (state.songs[index]?.trackArtistNames!.first == null) {
        return '';
      }
      if (state.songs[index]?.trackArtistNames!.first == '') {
        return '';
      }
      return '${state.songs[index]?.trackArtistNames!.first} - ';
    } catch (e) {
      return '';
    }
  }

  String getSongsDuration(final int index) {
    try {
      final Duration duration = Duration(
        seconds: state.songs[index]!.trackDuration!,
      );

      final int minutes = duration.inMinutes.remainder(60);
      final int seconds = duration.inSeconds.remainder(60);

      return '${minutes < 10 ? '0' : ''}$minutes:${seconds < 10 ? '0' : ''}$seconds';
    } catch (e) {
      return '';
    }
  }

  void getSongStats(final int index) {
    if (state.songs[index] == null) {
      return;
    }

    if (state.songs[index]!.filePath == null) {
      return;
    }

    final stat = FileStat.statSync(state.songs[index]!.filePath!);

    print('Accessed: ${stat.accessed}');
    print('Modified: ${stat.modified}');
    print('Changed: ${stat.changed}');
    print('size:  ${stat.size}');
  }
}
