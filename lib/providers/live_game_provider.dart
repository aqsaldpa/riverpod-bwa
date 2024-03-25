// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:riverpod_bwa/models/game.dart';
import 'package:riverpod_bwa/sources/game_source.dart';

part 'live_game_provider.g.dart';

@riverpod
class LiveGameNotifier extends _$LiveGameNotifier {
  @override
  LiveGameState build() => const LiveGameState("", '', []);

  fetchLiveGames() async {
    state = const LiveGameState("loading", '', []);
    await Future.delayed(const Duration(seconds: 2));
    final games = await GameSource.getLive();
    if (games == null) {
      state = const LiveGameState('failed', 'Something went wrong', []);
    } else {
      state = LiveGameState('success', '', games);
    }
  }
}

class LiveGameState extends Equatable {
  final String status;
  final String message;
  final List<Game> data;

  const LiveGameState(this.status, this.message, this.data);

  @override
  List<Object> get props => [status, message, data];
}
