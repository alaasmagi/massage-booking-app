import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:massage_booking_app/constants/l10n/localized_strings.dart';
import 'package:massage_booking_app/constants/styles.dart';
import 'package:massage_booking_app/utils/text_formatters.dart';
import 'package:massage_booking_app/views/widgets/common/standard_button.dart';

class LargeBookingCard extends StatelessWidget {
  const LargeBookingCard({
    super.key,
    required this.title,
    required this.dateTime,
    required this.imageUrl,
    required this.serviceProviderName,
    required this.serviceProviderTitle,
    required this.locationName,
    required this.locationAddress,
    required this.description,
    required this.controlsEnabled,
    this.onCancel,
    this.onMessage,
    this.onCollapse,
  });

  final String title;
  final DateTime dateTime;
  final String imageUrl;
  final String serviceProviderName;
  final String serviceProviderTitle;
  final String locationName;
  final String locationAddress;
  final String description;
  final bool controlsEnabled;
  final VoidCallback? onCancel;
  final VoidCallback? onMessage;
  final VoidCallback? onCollapse;


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            onTap: onCollapse,
            title: Text(
              title,
              style: theme.textTheme.titleLarge,
            ),
            subtitle: Text(
              TextFormatters.formatDateTime(dateTime),
              style: theme.textTheme.bodyMedium,
            ),
          trailing: FaIcon(
              FontAwesomeIcons.angleUp,
              color: theme.hintColor
          )),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.asset(
              'assets/services/$imageUrl',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                        child: FaIcon(
                          FontAwesomeIcons.solidUser,
                          color: theme.primaryColor,
                          size: 25,
                        )
                    ),
                    const SizedBox(width: 6),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          serviceProviderName,
                          style: theme.textTheme.titleMedium,
                        ),
                        Text(
                          serviceProviderTitle,
                          style: theme.textTheme.bodySmall
                              ?.copyWith(color: theme.hintColor),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: FaIcon(
                          FontAwesomeIcons.locationDot,
                          color: theme.primaryColor,
                          size: 25,
                      )
                    ),
                    const SizedBox(width: 6),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            locationName,
                          style: theme.textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          locationAddress,
                          style: theme.textTheme.bodySmall
                              ?.copyWith(color: theme.hintColor),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  description,
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          controlsEnabled
              ? Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: OverflowBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: [
                StandardButton(
                    height: AppSizeParameters.cardButtonHeight,
                    width: AppSizeParameters.cardButtonWidth,
                    label: LocalizedStrings.cancelBookingPromptButton,
                    filled: false,
                    onPressed: onCancel
                ),
                StandardButton(
                    height: AppSizeParameters.cardButtonHeight,
                    width: AppSizeParameters.cardButtonWidth,
                    icon: FontAwesomeIcons.solidPaperPlane,
                    label: LocalizedStrings.contactViaSMSButton,
                    filled: true,
                    onPressed: onMessage
                )
              ],
            ),
          )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
