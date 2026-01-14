import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:massage_booking_app/constants/l10n/localized_strings.dart';
import 'package:massage_booking_app/controllers/location_step_controller.dart';
import 'package:massage_booking_app/models/location/location.dart';
import 'package:massage_booking_app/views/widgets/common/empty_state.dart';
import 'package:massage_booking_app/views/widgets/locations/location_option_card.dart';

class LocationStep extends ConsumerStatefulWidget {
  final String? selectedLocationId;
  final void Function(String locationId, String locationName) onSelect;

  const LocationStep({
    super.key,
    required this.onSelect,
    this.selectedLocationId,
  });

  @override
  ConsumerState<LocationStep> createState() => _LocationStepState();
}

class _LocationStepState extends ConsumerState<LocationStep> {
  late final Future<List<Location>> _locationsFuture;
  late final LocationStepController _controller;
  late final ScrollController _scrollController;

  String? _selectedLocationId;

  static const double _itemWidth = 320;
  static const double _itemSpacing = 16;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _controller = LocationStepController(
      ref: ref,
      scrollController: _scrollController,
    );

    _locationsFuture = _controller.fetchLocations();
    _selectedLocationId = widget.selectedLocationId;

    if (_selectedLocationId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _locationsFuture.then((locations) {
          _controller.autoScrollToSelected(
            selectedLocationId: _selectedLocationId,
            locations: locations,
            itemWidth: _itemWidth,
            itemSpacing: _itemSpacing,
          );
        });
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _handleLocationTap(Location location, int index) {
    setState(() {
      _selectedLocationId = location.id;
    });

    widget.onSelect(location.id, location.name);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _controller.scrollToCenter(
          index: index,
          itemWidth: _itemWidth,
          itemSpacing: _itemSpacing,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Location>>(
      future: _locationsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingState();
        }

        if (snapshot.hasError) {
          return _buildErrorState(snapshot.error);
        }

        final locations = snapshot.data ?? [];

        if (locations.isEmpty) {
          return _buildEmptyState();
        }

        return _buildLocationsList(locations);
      },
    );
  }

  Widget _buildLoadingState() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildErrorState(Object? error) {
    return Center(child: Text('Error: $error'));
  }

  Widget _buildEmptyState() {
    return EmptyState(
      message: LocalizedStrings.noLocationsFoundPlaceholder,
    );
  }

  Widget _buildLocationsList(List<Location> locations) {
    return ListView.builder(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(16),
      key: const PageStorageKey('location_list'),
      itemCount: locations.length,
      itemBuilder: (context, index) => _buildLocationItem(locations[index], index),
    );
  }

  Widget _buildLocationItem(Location location, int index) {
    return Padding(
      padding: const EdgeInsets.only(right: _itemSpacing),
      child: SizedBox(
        width: _itemWidth,
        child: LocationOptionCard(
          title: location.name,
          address: location.address,
          description: location.description,
          isSelected: location.id == _selectedLocationId,
          onTap: () => _handleLocationTap(location, index),
        ),
      ),
    );
  }
}