part of 'songs_cubit.dart';

class SongsState {
  SongsState({required this.songs, this.loading = false});

  final List<SongModel?> songs;
  final bool loading;

  SongsState copyWith({
    final List<SongModel?>? songs,
    final bool? loading,
  }) {
    return SongsState(
      songs: songs ?? this.songs,
      loading: loading ?? this.loading,
    );
  }
}
