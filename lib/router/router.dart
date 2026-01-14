import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:massage_booking_app/models/booking/booking_draft.dart';
import 'package:massage_booking_app/views/auth/auth_view.dart';
import 'package:massage_booking_app/views/bookings/bookings_view.dart';
import 'package:massage_booking_app/views/confirm_booking/confirm_booking_view.dart';
import 'package:massage_booking_app/views/new_booking/new_booking_view.dart';
import 'package:massage_booking_app/views/settings/settings_view.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const AuthView();
      },
    ),
    GoRoute(
      path: '/bookings',
      builder: (BuildContext context, GoRouterState state) {
        return const BookingsView();
      },
    ),
    GoRoute(
      path: '/settings',
      builder: (BuildContext context, GoRouterState state) {
        return const SettingsView();
      },
    ),
    GoRoute(
      path: '/new-booking',
      builder: (BuildContext context, GoRouterState state) {
        return const NewBookingView();
      },
    ),
    GoRoute(
      path: '/confirm-booking',
      builder: (BuildContext context, GoRouterState state) {
        final extra = state.extra as Map<String, dynamic>?;
        if (extra == null) {
          return const AuthView();
        }
        return ConfirmBookingView(
          draft: extra['draft'] as BookingDraft,
          locationName: extra['locationName'] as String,
          serviceName: extra['serviceName'] as String,
          servicePrice: extra['servicePrice'] as double,
          providerName: extra['providerName'] as String,
        );
      },
    ),
  ],
);
