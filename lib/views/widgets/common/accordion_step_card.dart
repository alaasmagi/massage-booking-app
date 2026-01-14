import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:massage_booking_app/enums/bookings/booking_step.dart';

class AccordionStepCard extends StatelessWidget {
  final BookingStep currentStep;
  final BookingStep thisStep;
  final String title;
  final IconData icon;
  final Widget child;
  final String? selectionSummary;
  final VoidCallback? onTap;

  const AccordionStepCard({
    super.key,
    required this.currentStep,
    required this.thisStep,
    required this.title,
    required this.icon,
    required this.child,
    this.selectionSummary,
    this.onTap,
  });

  bool get isExpanded => currentStep == thisStep;
  bool get isCompleted => thisStep.index < currentStep.index;
  bool get isEnabled => thisStep.index <= currentStep.index;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isExpanded ? 4 : 1,
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: isCompleted
                  ? Theme.of(context).colorScheme.primaryContainer
                  : isEnabled
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey,
              child: isCompleted
                  ? const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 20,
                    )
                  : FaIcon(icon, color: Colors.white, size: 16),
            ),
            title: Text(
              title,
              style: TextStyle(
                fontWeight: isExpanded ? FontWeight.bold : FontWeight.normal,
                color: isEnabled ? null : Colors.grey,
              ),
            ),
            subtitle: selectionSummary != null
                ? Text(
                    selectionSummary!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 12,
                    ),
                  )
                : null,
            trailing: isEnabled
                ? FaIcon(isExpanded ? FontAwesomeIcons.angleUp :
                                      FontAwesomeIcons.angleDown)
                : const Icon(Icons.lock_outline, color: Colors.grey),
            onTap: isEnabled ? onTap : null,
          ),
          if (isExpanded) const Divider(height: 1),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.all(16),
              child: child,
            ),
        ],
      ),
    );
  }
}
