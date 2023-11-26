import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_music_player/core/utils/get_primary_color.dart';
import 'package:flutter_music_player/core/utils/sized_context.dart';
import 'package:flutter_music_player/core/widgets/app_main_navigation.dart';
import 'package:flutter_music_player/core/widgets/app_scaffold.dart';
import 'package:flutter_music_player/core/widgets/general_appbar.dart';
import 'package:flutter_music_player/features/home_feature/presentation/bloc/bottom_navigation_cubit.dart';
import 'package:flutter_music_player/features/home_feature/presentation/widgets/home_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    final List<Widget> pages = [
      Container(),
      Container(),
      Container(),
      const AppScaffold(
        appBar: GeneralAppBar(
          title: 'Settings',
        ),
        body: HomeBody(),
      ),
    ];
    return AppMainNavigation(
      body: IndexedStack(
        index: context.watch<BottomNavigationCubit>().state,
        children: pages,
      ),
      navigationRail: SizedBox(
        height: context.sizePx.height,
        child: NavigationRail(
          onDestinationSelected: (final int index) {
            context.read<BottomNavigationCubit>().onDestinationSelected(index);
          },
          indicatorColor: getPrimaryColor(context),
          selectedIndex: context.watch<BottomNavigationCubit>().state,
          labelType: NavigationRailLabelType.all,
          destinations: const <NavigationRailDestination>[
            NavigationRailDestination(
              selectedIcon: Icon(Icons.music_note),
              icon: Icon(Icons.music_note_outlined),
              label: Text('Songs'),
            ),
            NavigationRailDestination(
              selectedIcon: Icon(Icons.widgets),
              icon: Icon(Icons.widgets_outlined),
              label: Text('Albums'),
            ),
            NavigationRailDestination(
              selectedIcon: Icon(Icons.widgets),
              icon: Icon(Icons.widgets_outlined),
              label: Text('Artists'),
            ),
            NavigationRailDestination(
              selectedIcon: Icon(Icons.settings),
              icon: Icon(Icons.settings_outlined),
              label: Text('Profile'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (final int index) {
          context.read<BottomNavigationCubit>().onDestinationSelected(index);
        },
        indicatorColor: getPrimaryColor(context),
        selectedIndex: context.watch<BottomNavigationCubit>().state,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.music_note),
            icon: Icon(Icons.music_note_outlined),
            label: 'Songs',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.widgets),
            icon: Icon(Icons.widgets_outlined),
            label: 'Albums',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.widgets),
            icon: Icon(Icons.widgets_outlined),
            label: 'Artists',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.settings),
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
