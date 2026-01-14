abstract class LocalizedStrings {

  // General
  static const generalBack = 'Tagasi';
  static const generalCancel = 'Tühista';
  static const generalTryAgain = 'Proovi uuesti';
  static const biometricAuthenticationPrompt =
      'Autentige end biomeetriliselt, et jätkata.';
  static const nextButton = 'Järgmine';
  static const generalLoading = 'Laadimine...';

  // Login view
  static const loginWithGoogle = 'Logi sisse Google\'iga';
  static const loginWithMicrosoft = 'Logi sisse Microsoft\'iga';
  static const loginFailed = 'Sisselogimine ebaõnnestus!';

  // Bookings view
  static const myBookingsTitle = 'Minu broneeringud';
  static const noBookingsPlaceholder =
      'Sul hetkel puuduvad broneeringud. Tee oma esimene broneering nüüd!';
  static const newBookingButton = 'Uus broneering';
  static const cancelBookingPromptButton = 'Tühista broneering';
  static const contactViaSMSButton = 'Jäta teade';
  static const bookingCancellationConfirmation =
      'Kas oled kindel, et soovid selle broneeringu tühistada?';
  static const bookingCancellationSuccess = 'Broneering tühistatud';
  static const bookingCancellationFailure = 'Broneeringu tühistamine ebaõnnestus!';
  static const durationLabel = 'Kestus';

  // New booking flow
  static const newBookingTitle = 'Uus broneering';
  static const selectLocationStepTitle = 'Salong';
  static const selectServiceStepTitle = 'Teenus';
  static const selectServiceProviderStepTitle = 'Teenindaja';
  static const selectDateTimeStepTitle = 'Kuupäev ja kellaaeg';
  static const confirmBookingButton = 'Kinnita broneering';
  static const bookingConfirmationSuccess = 'Sinu broneering on edukalt loodud.';
  static const bookingConfirmationFailure = 'Broneeringu loomine ebaõnnestus!';
  static const selectedDateTimeNotAvailable =
      'Valitud kuupäev ja kellaaeg pole saadaval.';
  static const loginToConfirmBookingPrompt =
      'Palun logi sisse, et kinnitada oma broneering.';
  static const noLocationsFoundPlaceholder =
      'Salonge ei leitud. Proovi hiljem uuesti.';
  static const noServicesFoundPlaceholder =
      'Teenuseid ei leitud. Proovi hiljem uuesti.';
  static const noServiceProvidersFoundPlaceholder =
      'Teenindajaid ei leitud. Proovi hiljem uuesti.';

  // Booking confirmation
  static const bookingSummaryTitle = 'Broneeringu kokkuvõte';
  static const servicePrice = "Teenuse hind";
  static const bookingSummaryNote =
            'Enne broneeringu kinnitamist palun veendu andmete korrektsuses.';


  // Messaging
  static const phoneNumberNotFound = 'Telefoninumbrit ei leitud!';
  static const messagingAppFailed = 'Sõnumirakenduse avamine ebaõnnestus!';
  static const messagingAppFeature = 'Vau....sa avastasid tulevikus lisatava funktsioonaalsuse!';

  // Settings
  static const settingsTitle = 'Seaded';
  static const biometricAuthenticationTitle = 'Biomeetriline autentimine';
  static const biometricAuthenticationEnabled = 'Biomeetriline autentimine on sisselülitatud';
  static const biometricAuthenticationDisabled = 'Biomeetriline autentimine on väljalülitatud';
  static const biometricAuthenticationUnavailable = 'Biomeetriline autentimine pole hetkel saadaval';
  static const pushNotificationsTitle = 'Push-teavitused';
  static const pushNotificationsEnabled = 'Push-teavitused on sisselülitatud';
  static const pushNotificationsDisabled = 'Push-teavitused on väljalülitatud';
  static const pushNotificationsUnavailable = 'Push-teavitused on väljalülitatud pole hetkel saadaval';
  static const signOutConfirmationButton = 'Logi välja';
  static const signOutConfirmation =
      'Kas oled kindel, et soovid välja logida?';
  static const deleteMyDataConfirmationLink = 'Kustuta minu andmed';
  static const deleteMyDataConfirmation =
      'Kas oled kindel, et soovid oma konto ja kõik andmed kustutada? Seda toimingut ei saa tagasi võtta.';
  static const deleteMyDataConfirmButton = 'Kustuta';
  static const deleteMyDataFailure =
      'Andmete kustutamine ebaõnnestus! Proovi hiljem uuesti.';

  static const userProfileNameLabel = 'Nimi';
  static const userProfileEmailLabel = 'E-post';


  const LocalizedStrings._();
}
