import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:massage_booking_app/constants/l10n/localized_strings.dart';
import 'package:massage_booking_app/models/booking/booking.dart';
import 'package:massage_booking_app/providers/booking/booking_service_provider.dart';
import 'package:massage_booking_app/providers/booking/user_bookings_provider.dart';
import 'package:massage_booking_app/providers/message/messaging_service_provider.dart';
import 'package:massage_booking_app/services/loading_manager.dart';
import 'package:massage_booking_app/utils/snackbar_utils.dart';
import 'package:massage_booking_app/views/widgets/dialogs/confirmation_dialog.dart';

class BookingsController {
  final WidgetRef ref;
  final BuildContext context;
  final VoidCallback onExpandedChanged;

  BookingsController({
    required this.ref,
    required this.context,
    required this.onExpandedChanged,
  });

  Future<void> cancelBooking(Booking booking) async {
    final bookingService = ref.read(bookingServiceProvider);

    final confirmed = await ConfirmationDialog.show(
      context,
      title: LocalizedStrings.cancelBookingPromptButton,
      content: LocalizedStrings.bookingCancellationConfirmation,
      cancelText: LocalizedStrings.generalBack,
      confirmText: LocalizedStrings.cancelBookingPromptButton,
      isDestructive: true,
    );

    if (!confirmed) return;

    try {
      await LoadingManager.withLoading(ref, () async {
        await bookingService.cancelBooking(booking.id);
      });
      
      if (!context.mounted) return;
      
      onExpandedChanged();
      ref.invalidate(userBookingsProvider);
      SnackbarUtils.showSuccess(context, LocalizedStrings.bookingCancellationSuccess);
    } catch (_) {
      if (!context.mounted) return;
      SnackbarUtils.showError(context, LocalizedStrings.bookingCancellationFailure);
    }
  }

  Future<void> messageBooking(Booking booking) async {
    final messagingService = ref.read(messagingServiceProvider);

    final phone = booking.locationPhone.trim();
    if (!messagingService.isPhoneValid(phone)) {
      SnackbarUtils.showError(context, LocalizedStrings.phoneNumberNotFound);
      return;
    }

    final success = await LoadingManager.withLoading(ref, () async {
      await messagingService.sendBookingMessage(phone);
    });

    if (!success) {
      SnackbarUtils.showError(context, LocalizedStrings.messagingAppFailed);
    }
  }

  String? findClosestBookingId(List<Booking> bookings) {
    if (bookings.isEmpty) return null;
    final bookingService = ref.read(bookingServiceProvider);
    return bookingService.findClosestBookingId(bookings);
  }

  Future<void> refreshBookings() async {
    ref.invalidate(userBookingsProvider);
  }
}
