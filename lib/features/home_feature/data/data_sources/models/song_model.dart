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
    this.authorName,
    this.writerName,
    this.albumLength,
    this.bitrate,
    this.mimeType,
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

  /// Number of tracks in the album.
  final int? albumLength;

  /// Year of the track.
  final int? year;

  /// Genre of the track.
  final String? genre;

  /// Author of the track.
  final String? authorName;

  /// Writer of the track.
  final String? writerName;

  /// Number of the disc.
  final int? discNumber;

  /// Mime type.
  final String? mimeType;

  /// Duration of the track in milliseconds.
  final int? trackDuration;

  /// Bitrate of the track.
  final int? bitrate;

  /// [Uint8List] having album art data.
  final Uint8List? albumArt;

  /// File path of the media file. `null` on web.
  final String? filePath;
}
