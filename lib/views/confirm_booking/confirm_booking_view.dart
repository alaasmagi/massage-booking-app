import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:massage_booking_app/constants/l10n/localized_strings.dart';
import 'package:massage_booking_app/constants/styles.dart';
import 'package:massage_booking_app/controllers/confirm_booking_controller.dart';
import 'package:massage_booking_app/models/booking/booking_draft.dart';
import 'package:massage_booking_app/router/router.dart';
import 'package:massage_booking_app/utils/text_formatters.dart';
import 'package:massage_booking_app/views/widgets/bookings/summary_row.dart';
import 'package:massage_booking_app/views/widgets/common/standard_button.dart';
import 'package:massage_booking_app/views/widgets/common/standard_app_bar.dart';
import 'package:massage_booking_app/views/widgets/common/standard_icon_button.dart';
import 'package:massage_booking_app/views/widgets/bookings/info_message_card.dart';
import 'package:massage_booking_app/views/widgets/bookings/summary_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConfirmBookingView extends ConsumerStatefulWidget {
  final BookingDraft draft;
  final String locationName;
  final String serviceName;
  final double servicePrice;
  final String providerName;

  const ConfirmBookingView({
    super.key,
    required this.draft,
    required this.locationName,
    required this.serviceName,
    required this.servicePrice,
    required this.providerName,
  });

  @override
  ConsumerState<ConfirmBookingView> createState() => _ConfirmBookingViewState();
}

class _ConfirmBookingViewState extends ConsumerState<ConfirmBookingView> {
  late final ConfirmBookingController _controller;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _controller = ConfirmBookingController(
      ref: ref,
      context: context,
    );
  }

  Future<void> _handleSubmitBooking() async {
    if (_isSubmitting) return;

    setState(() => _isSubmitting = true);

    final success = await _controller.submitBooking(draft: widget.draft);

    if (mounted && !success) {
      setState(() => _isSubmitting = false);
    }
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
      title: LocalizedStrings.confirmBookingButton,
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
        const SizedBox(height: 12),
        _buildSummaryCard(),
        const SizedBox(height: 24),
        _buildInfoCard(),
        const SizedBox(height: 24),
        _buildConfirmButton(),
      ],
    );
  }

  Widget _buildSummaryCard() {
    return SummaryCard(
      title: LocalizedStrings.bookingSummaryTitle,
      rows: [
        SummaryRow(
          icon: FontAwesomeIcons.locationDot,
          label: LocalizedStrings.selectLocationStepTitle,
          value: widget.locationName,
        ),
        SummaryRow(
          icon: FontAwesomeIcons.spa,
          label: LocalizedStrings.selectServiceStepTitle,
          value: widget.serviceName,
        ),
        SummaryRow(
          icon: FontAwesomeIcons.userNurse,
          label: LocalizedStrings.selectServiceProviderStepTitle,
          value: widget.providerName,
        ),
        SummaryRow(
          icon: FontAwesomeIcons.clock,
          label: LocalizedStrings.selectDateTimeStepTitle,
          value: TextFormatters.formatDateTime(widget.draft.startTime!),
        ),
      ],
    );
  }

  Widget _buildInfoCard() {
    return InfoCard(
      leftLabel: LocalizedStrings.servicePrice,
      leftValue: TextFormatters.formatCurrency(widget.servicePrice),
      showDivider: true,
      bottomText: LocalizedStrings.bookingSummaryNote,
    );
  }

  Widget _buildConfirmButton() {
    return StandardButton(
      label: LocalizedStrings.confirmBookingButton,
      icon: FontAwesomeIcons.check,
      onPressed: _isSubmitting ? null : _handleSubmitBooking,
      height: AppSizeParameters.defaultButtonHeight,
      width: AppSizeParameters.primaryButtonWidth(context),
    );
  }
}