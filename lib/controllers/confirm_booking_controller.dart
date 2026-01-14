import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:massage_booking_app/constants/l10n/localized_strings.dart';
import 'package:massage_booking_app/models/booking/booking_draft.dart';
import 'package:massage_booking_app/providers/auth/user_id_provider.dart';
import 'package:massage_booking_app/providers/booking/booking_service_provider.dart';
import 'package:massage_booking_app/providers/booking/user_bookings_provider.dart';
import 'package:massage_booking_app/router/router.dart';
import 'package:massage_booking_app/services/loading_manager.dart';
import 'package:massage_booking_app/utils/snackbar_utils.dart';

class ConfirmBookingController {
  final WidgetRef ref;
  final BuildContext context;

  ConfirmBookingController({
    required this.ref,
    required this.context,
  });

  Future<bool> submitBooking({
    required BookingDraft draft,
  }) async {
    final userId = _getUserId();
    if (userId == null) {
      _showLoginRequiredError();
      return false;
    }

    final data = await _fetchBookingData(draft);
    if (data == null) {
      _showSubmissionError();
      return false;
    }

    final success = await _createBooking(
      draft: draft,
      userId: userId,
      data: data,
    );

    if (success) {
      _navigateToBookings();
    } else {
      _showSubmissionError();
    }

    return success;
  }

  String? _getUserId() {
    return ref.read(userIdProvider);
  }

  Future<dynamic> _fetchBookingData(BookingDraft draft) async {
    final bookingService = ref.read(bookingServiceProvider);

    try {
      return await LoadingManager.withLoading(ref, () async {
        return await bookingService.fetchBookingData(
          locationId: draft.locationId!,
          serviceId: draft.serviceId!,
          providerId: draft.serviceProviderId!,
        );
      });
    } catch (_) {
      return null;
    }
  }

  Future<bool> _createBooking({
    required BookingDraft draft,
    required String userId,
    required dynamic data,
  }) async {
    final bookingService = ref.read(bookingServiceProvider);

    try {
      await LoadingManager.withLoading(ref, () async {
        await bookingService.createBooking(
          service: data.service,
          provider: data.provider,
          location: data.location,
          userId: userId,
          startTime: draft.startTime!,
        );
      });
      return true;
    } catch (_) {
      return false;
    }
  }

  void _showLoginRequiredError() {
    if (!context.mounted) return;
    SnackbarUtils.showError(
      context,
      LocalizedStrings.loginToConfirmBookingPrompt,
    );
  }

  void _showSubmissionError() {
    if (!context.mounted) return;
    SnackbarUtils.showError(
      context,
      LocalizedStrings.bookingConfirmationFailure,
    );
  }

  void _navigateToBookings() {
    if (!context.mounted) return;
    ref.invalidate(userBookingsProvider);
    router.go('/bookings');
  }
}