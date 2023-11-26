import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'songs_state.dart';

class SongsCubit extends Cubit<SongsState> {
  SongsCubit() : super(SongsInitial());
}
