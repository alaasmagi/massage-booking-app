import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:massage_booking_app/models/service_provider/service_provider.dart';
import 'package:massage_booking_app/providers/service_providers/service_provider_service_provider.dart';
import 'package:massage_booking_app/views/new_booking/flow/scroll_controller.dart' as scroll_utils;

class ServiceProviderStepController {
  final WidgetRef ref;
  final ScrollController scrollController;

  ServiceProviderStepController({
    required this.ref,
    required this.scrollController,
  });

  Future<List<ServiceProvider>> fetchProviders(String serviceId) {
    final serviceProviderService = ref.read(serviceProviderServiceProvider);
    return serviceProviderService.getServiceProvidersByServiceId(serviceId);
  }

  void scrollToCenter({
    required int index,
    required double itemWidth,
    required double itemSpacing,
    double listPadding = 16,
  }) {
    scroll_utils.scrollToCenter(
      controller: scrollController,
      index: index,
      itemWidth: itemWidth,
      itemSpacing: itemSpacing,
      listPadding: listPadding,
    );
  }

  int findProviderIndex(List<ServiceProvider> providers, String providerId) {
    return providers.indexWhere((p) => p.id == providerId);
  }

  Future<void> autoScrollToSelected({
    required String? selectedProviderId,
    required List<ServiceProvider> providers,
    required double itemWidth,
    required double itemSpacing,
  }) async {
    if (selectedProviderId == null) return;

    final index = findProviderIndex(providers, selectedProviderId);
    if (index == -1) return;

    await Future.delayed(const Duration(milliseconds: 500));

    if (scrollController.hasClients) {
      scrollToCenter(
        index: index,
        itemWidth: itemWidth,
        itemSpacing: itemSpacing,
      );
    }
  }
}