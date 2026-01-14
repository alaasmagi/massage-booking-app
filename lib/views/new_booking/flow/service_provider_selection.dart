import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:massage_booking_app/constants/l10n/localized_strings.dart';
import 'package:massage_booking_app/controllers/service_provider_step_controller.dart';
import 'package:massage_booking_app/models/service_provider/service_provider.dart';
import 'package:massage_booking_app/views/widgets/common/empty_state.dart';
import 'package:massage_booking_app/views/widgets/service_providers/service_provider_option_card.dart';

class ServiceProviderStep extends ConsumerStatefulWidget {
  final String serviceId;
  final String? selectedProviderId;
  final void Function(String providerId, String providerName) onSelect;

  const ServiceProviderStep({
    super.key,
    required this.serviceId,
    required this.onSelect,
    this.selectedProviderId,
  });

  @override
  ConsumerState<ServiceProviderStep> createState() => _ServiceProviderStepState();
}

class _ServiceProviderStepState extends ConsumerState<ServiceProviderStep> {
  late final Future<List<ServiceProvider>> _providersFuture;
  late final ServiceProviderStepController _controller;
  late final ScrollController _scrollController;

  String? _selectedProviderId;

  static const double _itemWidth = 300;
  static const double _itemSpacing = 16;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _controller = ServiceProviderStepController(
      ref: ref,
      scrollController: _scrollController,
    );

    _providersFuture = _controller.fetchProviders(widget.serviceId);
    _selectedProviderId = widget.selectedProviderId;

    if (_selectedProviderId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _providersFuture.then((providers) {
          _controller.autoScrollToSelected(
            selectedProviderId: _selectedProviderId,
            providers: providers,
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

  void _handleProviderTap(ServiceProvider provider, int index) {
    setState(() {
      _selectedProviderId = provider.id;
    });

    widget.onSelect(provider.id, provider.fullName);

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
    return FutureBuilder<List<ServiceProvider>>(
      future: _providersFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingState();
        }

        if (snapshot.hasError) {
          return _buildErrorState(snapshot.error);
        }

        final providers = snapshot.data ?? [];

        if (providers.isEmpty) {
          return _buildEmptyState();
        }

        return _buildProvidersList(providers);
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
      message: LocalizedStrings.noServiceProvidersFoundPlaceholder,
    );
  }

  Widget _buildProvidersList(List<ServiceProvider> providers) {
    return ListView.builder(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(16),
      key: const PageStorageKey('provider_list'),
      itemCount: providers.length,
      itemBuilder: (context, index) => _buildProviderItem(providers[index], index),
    );
  }

  Widget _buildProviderItem(ServiceProvider provider, int index) {
    return Padding(
      padding: const EdgeInsets.only(right: _itemSpacing),
      child: SizedBox(
        width: _itemWidth,
        child: ServiceProviderOptionCard(
          fullName: provider.fullName,
          title: provider.title,
          popularity: provider.popularity,
          isSelected: provider.id == _selectedProviderId,
          onTap: () => _handleProviderTap(provider, index),
        ),
      ),
    );
  }
}