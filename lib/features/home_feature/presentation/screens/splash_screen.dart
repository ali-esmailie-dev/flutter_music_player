import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_music_player/core/localization/i18n/translations.g.dart';
import 'package:flutter_music_player/core/routes/go_routes_path.dart';
import 'package:flutter_music_player/core/theme/dimens.dart';
import 'package:flutter_music_player/core/utils/get_app_version.dart';
import 'package:flutter_music_player/core/utils/sized_context.dart';
import 'package:flutter_music_player/core/widgets/app_loading.dart';
import 'package:flutter_music_player/core/widgets/app_scaffold.dart';
import 'package:flutter_music_player/core/widgets/app_space.dart';
import 'package:flutter_music_player/core/widgets/buttons/app_outlined_button.dart';
import 'package:flutter_music_player/core/widgets/typography/app_text.dart';
import 'package:flutter_music_player/features/home_feature/presentation/bloc/songs_cubit.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    navigateToHome(context: context);
    return AppScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: FlutterLogo(
              size: 100,
            ),
          ),
          BlocBuilder<SongsCubit, SongsState>(
            builder: (final context, final state) {
              if (state.loading) {
                return Padding(
                  padding: EdgeInsets.only(
                    top: context.heightPx * 0.1,
                  ),
                  child: const AppLoading(),
                );
              } else {
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: context.heightPx * 0.1,
                        left: context.widthPx * 0.1,
                        right: context.widthPx * 0.1,
                      ),
                      child: AppText(
                        t.grantMediaPermission,
                        maxLines: 3,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const AppVSpace(),
                    AppOutlinedButton(
                      onPressed: () async {
                        final bool status = await context
                            .read<SongsCubit>()
                            .requestPermission();
                        if (context.mounted && status) {
                          navigateToHome(context: context);
                        }
                      },
                      child: AppText(t.allow),
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
      bottomSheet: SizedBox(
        height: Dimens.bottomSheetHeight,
        child: Center(
          child: FutureBuilder(
            future: getAppVersion(),
            builder: (
              final BuildContext context,
              final AsyncSnapshot<String> snapshot,
            ) {
              String version = '';
              if (snapshot.hasData) {
                version = snapshot.data ?? '';
              }
              return Text(t.version(version: version));
            },
          ),
        ),
      ),
    );
  }

  Future<void> navigateToHome({
    required final BuildContext context,
  }) async {
    if (await context.read<SongsCubit>().checkMediaPermission()) {
      if (context.mounted) {
        await context.read<SongsCubit>().getSongs();
        Timer(const Duration(milliseconds: 15), () {
          context.pushReplacement(GoRoutesPath.home);
        });
      }
    }
  }
}
