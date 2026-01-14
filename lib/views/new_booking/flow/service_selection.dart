import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:massage_booking_app/constants/l10n/localized_strings.dart';
import 'package:massage_booking_app/controllers/service_step_controller.dart';
import 'package:massage_booking_app/models/service/service.dart';
import 'package:massage_booking_app/views/widgets/common/empty_state.dart';
import 'package:massage_booking_app/views/widgets/services/service_option_card.dart';

class ServiceStep extends ConsumerStatefulWidget {
  final String locationId;
  final String? selectedServiceId;
  final void Function(String serviceId, String serviceName, double servicePrice) onSelect;

  const ServiceStep({
    super.key,
    required this.locationId,
    required this.onSelect,
    this.selectedServiceId,
  });

  @override
  ConsumerState<ServiceStep> createState() => _ServiceStepState();
}

class _ServiceStepState extends ConsumerState<ServiceStep> {
  late final Future<List<Service>> _servicesFuture;
  late final ServiceStepController _controller;
  late final ScrollController _scrollController;

  String? _selectedServiceId;

  static const double _itemWidth = 300;
  static const double _itemSpacing = 16;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _controller = ServiceStepController(
      ref: ref,
      scrollController: _scrollController,
    );

    _selectedServiceId = widget.selectedServiceId;
    _servicesFuture = _controller.fetchServices();

    if (_selectedServiceId != null) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _servicesFuture.then((services) {
          _controller.autoScrollToSelected(
            selectedServiceId: _selectedServiceId,
            services: services,
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

  void _handleServiceTap(Service service, int index) {
    setState(() {
      _selectedServiceId = service.id;
    });

    widget.onSelect(service.id, service.name, service.price);

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
    return FutureBuilder<List<Service>>(
      future: _servicesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingState();
        }

        if (snapshot.hasError) {
          return _buildErrorState(snapshot.error);
        }

        final services = snapshot.data ?? [];

        if (services.isEmpty) {
          return _buildEmptyState();
        }

        return _buildServicesList(services);
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
      message: LocalizedStrings.noServicesFoundPlaceholder,
    );
  }

  Widget _buildServicesList(List<Service> services) {
    return SizedBox(
      height: 440,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        key: const PageStorageKey('service_list'),
        itemCount: services.length,
        itemBuilder: (context, index) => _buildServiceItem(services[index], index),
      ),
    );
  }

  Widget _buildServiceItem(Service service, int index) {
    return Padding(
      padding: const EdgeInsets.only(right: _itemSpacing),
      child: SizedBox(
        width: _itemWidth,
        child: ServiceOptionCard(
          name: service.name,
          description: service.description,
          duration: service.duration,
          price: service.price,
          thumbnail: service.thumbnail,
          isSelected: service.id == _selectedServiceId,
          onTap: () => _handleServiceTap(service, index),
        ),
      ),
    );
  }
}