import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:massage_booking_app/constants/l10n/localized_strings.dart';
import 'package:massage_booking_app/constants/styles.dart';
import 'package:massage_booking_app/controllers/bookings_controller.dart';
import 'package:massage_booking_app/models/booking/booking.dart';
import 'package:massage_booking_app/providers/booking/user_bookings_provider.dart';
import 'package:massage_booking_app/router/router.dart';
import 'package:massage_booking_app/views/widgets/bookings/large_booking_card.dart';
import 'package:massage_booking_app/views/widgets/bookings/small_booking_card.dart';
import 'package:massage_booking_app/views/widgets/common/empty_state.dart';
import 'package:massage_booking_app/views/widgets/common/standard_app_bar.dart';
import 'package:massage_booking_app/views/widgets/common/standard_button.dart';
import 'package:massage_booking_app/views/widgets/common/standard_icon_button.dart';

class BookingsView extends ConsumerStatefulWidget {
  const BookingsView({super.key});

  @override
  ConsumerState<BookingsView> createState() => _BookingsViewState();
}

class _BookingsViewState extends ConsumerState<BookingsView> {
  String? expandedBookingId;

  late final BookingsController _controller;

  @override
  void initState() {
    super.initState();
    _controller = BookingsController(
      ref: ref,
      context: context,
      onExpandedChanged: _collapseBooking,
    );
  }

  void _collapseBooking() {
    setState(() {
      expandedBookingId = null;
    });
  }

  void _expandBooking(String bookingId) {
    setState(() {
      expandedBookingId = bookingId;
    });
  }

  void _initializeExpandedBooking(List<Booking> bookings) {
    if (expandedBookingId == null && bookings.isNotEmpty) {
      final nextId = _controller.findClosestBookingId(bookings);
      if (nextId != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            setState(() {
              expandedBookingId = nextId;
            });
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bookingsAsync = ref.watch(userBookingsProvider);

    return Scaffold(
      appBar: _buildAppBar(),
      floatingActionButton: _buildFloatingActionButton(),
      body: SafeArea(
        child: bookingsAsync.when(
          loading: () => _buildLoadingState(),
          error: (e, _) => _buildErrorState(e),
          data: (bookings) => _buildBookingsList(bookings),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return StandardAppBar(
      title: LocalizedStrings.myBookingsTitle,
      actions: [
        StandardIconButton(
          icon: FontAwesomeIcons.userGear,
          filled: true,
          onPressed: () => router.push("/settings"),
        ),
      ],
    );
  }

  Widget _buildFloatingActionButton() {
    return SizedBox(
      height: 52,
      child: StandardButton(
        label: LocalizedStrings.newBookingButton,
        icon: FontAwesomeIcons.plus,
        onPressed: () => router.push("/new-booking"),
        height: AppSizeParameters.defaultButtonHeight,
        width: AppSizeParameters.floatingButtonWidth,
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildErrorState(Object error) {
    return Center(child: Text('Error: $error'));
  }

  Widget _buildBookingsList(List<Booking> bookings) {
    if (bookings.isEmpty) {
      return const EmptyState(
        message: LocalizedStrings.noBookingsPlaceholder,
      );
    }

    _initializeExpandedBooking(bookings);

    return RefreshIndicator(
      onRefresh: _controller.refreshBookings,
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
        itemCount: bookings.length,
        itemBuilder: (context, index) => _buildBookingItem(bookings[index]),
      ),
    );
  }

  Widget _buildBookingItem(Booking booking) {
    final isExpanded = booking.id == expandedBookingId;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      child: isExpanded
          ? _buildLargeBookingCard(booking)
          : _buildSmallBookingCard(booking),
    );
  }

  Widget _buildLargeBookingCard(Booking booking) {
    return LargeBookingCard(
      key: ValueKey('large-${booking.id}'),
      title: booking.serviceName,
      dateTime: booking.startTime,
      imageUrl: booking.serviceThumbnail,
      serviceProviderName: booking.providerFullName,
      serviceProviderTitle: booking.providerTitle,
      locationAddress: booking.address,
      locationName: booking.locationName,
      description: booking.serviceDescription,
      controlsEnabled: true,
      onCancel: () => _controller.cancelBooking(booking),
      onMessage: () => _controller.messageBooking(booking),
      onCollapse: _collapseBooking,
    );
  }

  Widget _buildSmallBookingCard(Booking booking) {
    return SmallBookingCard(
      key: ValueKey('small-${booking.id}'),
      booking: booking,
      onTap: () => _expandBooking(booking.id),
    );
  }
}