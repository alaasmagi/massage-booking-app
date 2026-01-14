import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'loading_provider.g.dart';

@riverpod
class LoadingState extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  void show() {
    state = true;
  }

  void hide() {
    state = false;
  }

  void toggle() {
    state = !state;
  }
}

@riverpod
bool isLoadingNotifier(Ref ref) {
  return ref.watch(loadingStateProvider);
}
