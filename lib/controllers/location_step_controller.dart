import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:massage_booking_app/models/location/location.dart';
import 'package:massage_booking_app/providers/locations/location_service_provider.dart';
import 'package:massage_booking_app/services/location/location_service.dart';
import 'package:massage_booking_app/views/new_booking/flow/scroll_controller.dart' as scroll_utils;

class LocationStepController {
  final WidgetRef ref;
  final ScrollController scrollController;

  LocationStepController({
    required this.ref,
    required this.scrollController,
  });

  Future<List<Location>> fetchLocations() {
    final locationService = ref.read(locationServiceProvider);
    return locationService.getAllLocations();
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

  int findLocationIndex(List<Location> locations, String locationId) {
    return locations.indexWhere((l) => l.id == locationId);
  }

  Future<void> autoScrollToSelected({
    required String? selectedLocationId,
    required List<Location> locations,
    required double itemWidth,
    required double itemSpacing,
  }) async {
    if (selectedLocationId == null) return;

    final index = findLocationIndex(locations, selectedLocationId);
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