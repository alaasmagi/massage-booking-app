import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:massage_booking_app/providers/loading/loading_provider.dart';

class LoadingManager {
  static void show(WidgetRef ref) {
    ref.read(loadingStateProvider.notifier).show();
  }

  static void hide(WidgetRef ref) {
    ref.read(loadingStateProvider.notifier).hide();
  }

  static void toggle(WidgetRef ref) {
    ref.read(loadingStateProvider.notifier).toggle();
  }

  static Future<T> withLoading<T>(WidgetRef ref, Future<T> Function() operation) async {
    show(ref);
    try {
      return await operation();
    }
    finally {
      hide(ref);
    }
  }
}
