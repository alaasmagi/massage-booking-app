import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:massage_booking_app/constants/l10n/localized_strings.dart';
import 'package:massage_booking_app/constants/styles.dart';
import 'package:massage_booking_app/controllers/new_booking_controller.dart';
import 'package:massage_booking_app/enums/bookings/booking_step.dart';
import 'package:massage_booking_app/models/booking/booking_draft.dart';
import 'package:massage_booking_app/router/router.dart';
import 'package:massage_booking_app/utils/text_formatters.dart';
import 'package:massage_booking_app/views/new_booking/flow/location_selection.dart';
import 'package:massage_booking_app/views/new_booking/flow/service_provider_selection.dart';
import 'package:massage_booking_app/views/new_booking/flow/service_selection.dart';
import 'package:massage_booking_app/views/new_booking/flow/time_selection.dart';
import 'package:massage_booking_app/views/widgets/common/accordion_step_card.dart';
import 'package:massage_booking_app/views/widgets/common/standard_app_bar.dart';
import 'package:massage_booking_app/views/widgets/common/standard_button.dart';
import 'package:massage_booking_app/views/widgets/common/standard_icon_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewBookingView extends ConsumerStatefulWidget {
  const NewBookingView({super.key});

  @override
  ConsumerState<NewBookingView> createState() => _NewBookingViewState();
}

class _NewBookingViewState extends ConsumerState<NewBookingView> {
  late final NewBookingController _controller;

  BookingDraft _draft = const BookingDraft();
  BookingStep _currentStep = BookingStep.location;

  String? _selectedLocationId;
  String? _selectedLocationName;
  String? _selectedServiceId;
  String? _selectedServiceName;
  double? _selectedServicePrice;
  String? _selectedProviderId;
  String? _selectedProviderName;
  DateTime? _selectedStartTime;
  bool? _isBookingAvailable;

  @override
  void initState() {
    super.initState();
    _controller = NewBookingController(
      ref: ref,
      context: context,
      updateState: setState,
    );
  }

  void _handleLocationSelected(String id, String name) {
    setState(() {
      _selectedLocationId = id;
      _selectedLocationName = name;
      _draft = _controller.updateLocation(currentDraft: _draft, locationId: id);
      _currentStep = BookingStep.service;
    });
  }

  void _handleServiceSelected(String id, String name, double price) {
    setState(() {
      _selectedServiceId = id;
      _selectedServiceName = name;
      _selectedServicePrice = price;
      _draft = _controller.updateService(currentDraft: _draft, serviceId: id);
      _currentStep = BookingStep.provider;
    });
  }

  void _handleProviderSelected(String id, String name) {
    setState(() {
      _selectedProviderId = id;
      _selectedProviderName = name;
      _draft = _controller.updateProvider(currentDraft: _draft, providerId: id);
      _currentStep = BookingStep.datetime;
    });
  }

  Future<void> _handleTimeSelected(DateTime selected) async {
    setState(() {
      _selectedStartTime = selected;
      _draft = _controller.updateStartTime(currentDraft: _draft, startTime: selected);
      _isBookingAvailable = null;
    });

    final isAvailable = await _controller.validateTimeSelection(
      selectedTime: selected,
      draft: _draft,
    );

    if (mounted) {
      setState(() {
        _isBookingAvailable = isAvailable;
      });
    }
  }

  void _navigateToConfirmBooking() {
    if (_selectedLocationName == null ||
        _selectedServiceName == null ||
        _selectedServicePrice == null ||
        _selectedProviderName == null) {
      return;
    }

    _controller.navigateToConfirmation(
      draft: _draft,
      locationName: _selectedLocationName!,
      serviceName: _selectedServiceName!,
      servicePrice: _selectedServicePrice!,
      providerName: _selectedProviderName!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return StandardAppBar(
      title: LocalizedStrings.newBookingTitle,
      onBackPressed: () => router.pop(),
      actions: [
        StandardIconButton(
          icon: FontAwesomeIcons.userGear,
          filled: true,
          onPressed: () => context.push('/settings'),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildLocationStep(),
        const SizedBox(height: 12),
        _buildServiceStep(),
        const SizedBox(height: 12),
        _buildProviderStep(),
        const SizedBox(height: 12),
        _buildDateTimeStep(),
        const SizedBox(height: 24),
        if (_controller.canSubmitBooking(_draft, _isBookingAvailable))
          _buildSubmitButton(),
      ],
    );
  }

  Widget _buildLocationStep() {
    return AccordionStepCard(
      currentStep: _currentStep,
      thisStep: BookingStep.location,
      title: LocalizedStrings.selectLocationStepTitle,
      icon: FontAwesomeIcons.locationDot,
      selectionSummary: _selectedLocationName,
      onTap: () => setState(() => _currentStep = BookingStep.location),
      child: SizedBox(
        height: 300,
        child: LocationStep(
          key: ValueKey('location_${_currentStep == BookingStep.location}'),
          selectedLocationId: _selectedLocationId,
          onSelect: _handleLocationSelected,
        ),
      ),
    );
  }

  Widget _buildServiceStep() {
    return AccordionStepCard(
      currentStep: _currentStep,
      thisStep: BookingStep.service,
      title: LocalizedStrings.selectServiceStepTitle,
      icon: FontAwesomeIcons.spa,
      selectionSummary: _selectedServiceName != null
          ? TextFormatters.formatServiceSummary(
        _selectedServiceName!,
        _selectedServicePrice,
      )
          : null,
      onTap: () => setState(() => _currentStep = BookingStep.service),
      child: _draft.locationId != null
          ? SizedBox(
        height: 460,
        child: ServiceStep(
          key: ValueKey('service_${_currentStep == BookingStep.service}'),
          locationId: _draft.locationId!,
          selectedServiceId: _selectedServiceId,
          onSelect: _handleServiceSelected,
        ),
      )
          : const SizedBox.shrink(),
    );
  }

  Widget _buildProviderStep() {
    return AccordionStepCard(
      currentStep: _currentStep,
      thisStep: BookingStep.provider,
      title: LocalizedStrings.selectServiceProviderStepTitle,
      icon: FontAwesomeIcons.userNurse,
      selectionSummary: _selectedProviderName,
      onTap: () => setState(() => _currentStep = BookingStep.provider),
      child: _draft.serviceId != null
          ? SizedBox(
        height: 300,
        child: ServiceProviderStep(
          key: ValueKey('provider_${_currentStep == BookingStep.provider}'),
          serviceId: _draft.serviceId!,
          selectedProviderId: _selectedProviderId,
          onSelect: _handleProviderSelected,
        ),
      )
          : const SizedBox.shrink(),
    );
  }

  Widget _buildDateTimeStep() {
    return AccordionStepCard(
      currentStep: _currentStep,
      thisStep: BookingStep.datetime,
      title: LocalizedStrings.selectDateTimeStepTitle,
      icon: FontAwesomeIcons.clock,
      selectionSummary: _selectedStartTime != null
          ? TextFormatters.formatDateTime(_selectedStartTime!)
          : null,
      onTap: () => setState(() => _currentStep = BookingStep.datetime),
      child: _draft.serviceProviderId != null
          ? DateTimeStep(
        providerId: _draft.serviceProviderId!,
        selectedDateTime: _selectedStartTime,
        onSelect: _handleTimeSelected,
      )
          : const SizedBox.shrink(),
    );
  }

  Widget _buildSubmitButton() {
    return StandardButton(
      height: AppSizeParameters.defaultButtonHeight,
      width: AppSizeParameters.primaryButtonWidth(context),
      label: LocalizedStrings.nextButton,
      icon: FontAwesomeIcons.arrowRight,
      filled: true,
      onPressed: _navigateToConfirmBooking,
    );
  }
}