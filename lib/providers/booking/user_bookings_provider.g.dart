// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_bookings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(userBookings)
const userBookingsProvider = UserBookingsProvider._();

final class UserBookingsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Booking>>,
          List<Booking>,
          FutureOr<List<Booking>>
        >
    with $FutureModifier<List<Booking>>, $FutureProvider<List<Booking>> {
  const UserBookingsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userBookingsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userBookingsHash();

  @$internal
  @override
  $FutureProviderElement<List<Booking>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Booking>> create(Ref ref) {
    return userBookings(ref);
  }
}

String _$userBookingsHash() => r'2037531dc43e1f8fac3b5d7d3bf9f668c73b1fa1';
