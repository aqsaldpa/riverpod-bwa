import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_bwa/models/game.dart';
import 'package:riverpod_bwa/providers/live_game_provider.dart';
import 'package:extended_image/extended_image.dart';

class LiveGamesPages extends ConsumerStatefulWidget {
  const LiveGamesPages({super.key});

  @override
  ConsumerState<LiveGamesPages> createState() => _LiveGamesPagesState();
}

class _LiveGamesPagesState extends ConsumerState<LiveGamesPages> {
  @override
  void initState() {
    Future.microtask(
        () => ref.read(liveGameNotifierProvider.notifier).fetchLiveGames());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Belajar Riverpod"),
      ),
      body: Consumer(
        builder: (context, wiRef, child) {
          LiveGameState state = wiRef.watch(liveGameNotifierProvider);
          if (state.status == '') return const SizedBox.shrink();
          if (state.status == 'loading') {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.status == 'failed') {
            return Center(
              child: Text(state.message),
            );
          }
          List<Game> games = state.data;
          return GridView.builder(
            itemCount: games.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              Game game = games[index];
              return ExtendedImage.network(
                game.thumbnail!,
                fit: BoxFit.cover,
              );
            },
          );
        },
      ),
    );
  }
}
