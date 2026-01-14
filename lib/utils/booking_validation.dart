import 'package:massage_booking_app/models/booking/booking_draft.dart';

class BookingValidation {
  static bool canSubmitBooking(BookingDraft draft) {
    return draft.locationId != null &&
        draft.serviceId != null &&
        draft.serviceProviderId != null &&
        draft.startTime != null;
  }
}
