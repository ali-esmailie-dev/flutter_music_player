import 'dart:typed_data';

class SongModel {
  SongModel({
    this.trackArtistNames,
    this.albumName,
    this.filePath,
    this.trackDuration,
    this.albumArt,
    this.genre,
    this.year,
    this.trackNumber,
    this.discNumber,
    this.trackName,
    this.albumArtistName,
  });

  /// Name of the track.
  final String? trackName;

  /// Names of the artists performing in the track.
  final List<String>? trackArtistNames;

  /// Name of the album.
  final String? albumName;

  /// Name of the album artist.
  final String? albumArtistName;

  /// Position of track in the album.
  final int? trackNumber;

  /// Year of the track.
  final int? year;

  /// Genre of the track.
  final String? genre;

  /// Number of the disc.
  final int? discNumber;

  /// Duration of the track in seconds.
  final int? trackDuration;

  /// [Uint8List] having album art data.
  final Uint8List? albumArt;

  /// File path of the media file.
  final String? filePath;
}
