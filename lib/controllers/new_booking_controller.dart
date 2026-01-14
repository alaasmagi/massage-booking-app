import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:massage_booking_app/constants/l10n/localized_strings.dart';
import 'package:massage_booking_app/enums/bookings/booking_step.dart';
import 'package:massage_booking_app/models/booking/booking_draft.dart';
import 'package:massage_booking_app/providers/auth/user_id_provider.dart';
import 'package:massage_booking_app/providers/booking/booking_availability_service_provider.dart';
import 'package:massage_booking_app/providers/booking/booking_service_provider.dart';
import 'package:massage_booking_app/services/loading_manager.dart';
import 'package:massage_booking_app/utils/snackbar_utils.dart';
import 'package:massage_booking_app/utils/booking_validation.dart';

class NewBookingController {
  final WidgetRef ref;
  final BuildContext context;
  final void Function(VoidCallback fn) updateState;

  NewBookingController({
    required this.ref,
    required this.context,
    required this.updateState,
  });

  Future<bool> validateTimeSelection({
    required DateTime selectedTime,
    required BookingDraft draft,
  }) async {
    final bookingService = ref.read(bookingServiceProvider);
    final availabilityService = ref.read(bookingAvailabilityServiceProvider);
    final userId = ref.read(userIdProvider);

    final locationId = draft.locationId;
    final serviceId = draft.serviceId;
    final providerId = draft.serviceProviderId;

    if (locationId == null || serviceId == null || providerId == null) {
      return false;
    }

    bool isAvailable = false;

    await LoadingManager.withLoading(ref, () async {
      final data = await bookingService.fetchBookingData(
        locationId: locationId,
        serviceId: serviceId,
        providerId: providerId,
      );

      if (!context.mounted) return;

      if (data == null) {
        SnackbarUtils.showError(
          context,
          LocalizedStrings.selectedDateTimeNotAvailable,
        );
        return;
      }

      final endTime = selectedTime.add(Duration(minutes: data.service.duration));
      isAvailable = await availabilityService.isBookingAvailable(
        userId: userId!,
        location: data.location,
        providerId: providerId,
        start: selectedTime,
        end: endTime,
      );

      if (!context.mounted) return;

      if (!isAvailable) {
        SnackbarUtils.showError(
          context,
          LocalizedStrings.selectedDateTimeNotAvailable,
        );
      }
    });

    return isAvailable;
  }

  void navigateToConfirmation({
    required BookingDraft draft,
    required String locationName,
    required String serviceName,
    required double servicePrice,
    required String providerName,
  }) {
    if (!BookingValidation.canSubmitBooking(draft)) {
      return;
    }

    context.push(
      '/confirm-booking',
      extra: {
        'draft': draft,
        'locationName': locationName,
        'serviceName': serviceName,
        'servicePrice': servicePrice,
        'providerName': providerName,
      },
    );
  }

  BookingDraft updateLocation({
    required BookingDraft currentDraft,
    required String locationId,
  }) {
    return currentDraft.copyWith(locationId: locationId);
  }

  BookingDraft updateService({
    required BookingDraft currentDraft,
    required String serviceId,
  }) {
    return currentDraft.copyWith(serviceId: serviceId);
  }

  BookingDraft updateProvider({
    required BookingDraft currentDraft,
    required String providerId,
  }) {
    return currentDraft.copyWith(serviceProviderId: providerId);
  }

  BookingDraft updateStartTime({
    required BookingDraft currentDraft,
    required DateTime startTime,
  }) {
    return currentDraft.copyWith(startTime: startTime);
  }

  bool canSubmitBooking(BookingDraft draft, bool? isAvailable) {
    return BookingValidation.canSubmitBooking(draft) && isAvailable == true;
  }
}
