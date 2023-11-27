import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:flutter_music_player/core/utils/app_permissions_helper.dart';
import 'package:flutter_music_player/features/home_feature/data/data_sources/models/song_model.dart';
import 'package:permission_handler/permission_handler.dart';

part 'songs_state.dart';

class SongsCubit extends Cubit<SongsState> {
  SongsCubit() : super(SongsState(songs: []));

  final List<SongModel?> songsEntity = [];

  void getSongs() {
    AppPermissionHelper.checkPermissionStatus(Permission.storage)
        .then((final bool hasPermission) async {
      if (hasPermission) {
        final Directory directory = Directory('/storage/emulated/0/');

        final List<FileSystemEntity> entities = directory.listSync().toList();

        findSongs(entities);
        emit(state.copyWith(songs: songsEntity));

        // final stat = FileStat.statSync(songs.first.path);
        // print('Accessed: ${stat.accessed}');
        // print('Modified: ${stat.modified}');
        // print('Changed: ${stat.changed}');
        // print('size:  ${stat.size}');
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

  Future<void> checkAndAddSong(final FileSystemEntity directoryEntity) async {
    if (directoryEntity.path.toLowerCase().contains('.mp3')) {
      final Metadata? metaData = await getSongMetadata(directoryEntity);

      if (metaData == null) {
        songsEntity.add(null);
      } else {
        songsEntity.add(
          SongModel(
            trackArtistNames: metaData.trackArtistNames,
            albumArtistName: metaData.albumName,
            filePath: metaData.filePath,
            trackDuration: metaData.trackDuration,
            albumArt: metaData.albumArt,
            genre: metaData.genre,
            year: metaData.year,
            trackNumber: metaData.trackNumber,
            discNumber: metaData.discNumber,
            trackName: metaData.trackName,
            authorName: metaData.authorName,
            writerName: metaData.writerName,
            albumLength: metaData.albumLength,
            bitrate: metaData.bitrate,
            mimeType: metaData.mimeType,
          ),
        );
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
      return state.songs[index]!.filePath!.split('/').last.replaceAll(
        '.mp3',
        '',
      );
    } catch (e) {
      return '';
    }
  }

  String getSongArtistName(final int index) {
    try {
      return state.songs[index]?.trackArtistNames!.first ?? '';
    } catch (e) {
      return '';
    }
  }
}
