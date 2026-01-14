import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:massage_booking_app/models/service/service.dart';
import 'package:massage_booking_app/providers/services/service_service_provider.dart';
import 'package:massage_booking_app/views/new_booking/flow/scroll_controller.dart' as scroll_utils;

class ServiceStepController {
  final WidgetRef ref;
  final ScrollController scrollController;

  ServiceStepController({
    required this.ref,
    required this.scrollController,
  });

  Future<List<Service>> fetchServices() {
    final serviceService = ref.read(serviceServiceProvider);
    return serviceService.getAllServices();
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

  int findServiceIndex(List<Service> services, String serviceId) {
    return services.indexWhere((s) => s.id == serviceId);
  }

  Future<void> autoScrollToSelected({
    required String? selectedServiceId,
    required List<Service> services,
    required double itemWidth,
    required double itemSpacing,
  }) async {
    if (selectedServiceId == null) return;

    final index = findServiceIndex(services, selectedServiceId);
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