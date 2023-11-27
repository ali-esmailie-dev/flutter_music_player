part of 'songs_cubit.dart';

class SongsState {
  SongsState({required this.songs});

  final List<SongModel?> songs;

  SongsState copyWith({
    final List<SongModel?>? songs,
  }) {
    return SongsState(songs: songs ?? this.songs);
  }
}
