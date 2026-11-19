import 'package:flutter/material.dart';
import 'app_style.dart';
import 'models.dart';

/// Shows the "Did you go to ...?" pop-up over whatever screen is current.
Future<void> showVisitFeedback(BuildContext context, String placeName) {
  return showDialog(
    context: context,
    builder: (_) => VisitFeedbackDialog(placeName: placeName),
  );
}

class VisitFeedbackDialog extends StatefulWidget {
  final String placeName;
  const VisitFeedbackDialog({super.key, required this.placeName});

  @override
  State<VisitFeedbackDialog> createState() => _VisitFeedbackDialogState();
}

class _VisitFeedbackDialogState extends State<VisitFeedbackDialog> {
  bool? _went;
  int _stars = 0;
  String? _feeling;
  final Set<String> _goodFor = {};
  String? _price;

  Widget _label(String text) => Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 8),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      );

  void _submit() {
    final messenger = ScaffoldMessenger.of(context);
    Navigator.pop(context);
    messenger.showSnackBar(
      const SnackBar(content: Text('Thanks for your feedback!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shape: roundedShape(),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: SingleChildScrollView(
        padding: kPagePadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Did you go to ${widget.placeName}?',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ChipButton(
                    label: 'Yes',
                    selected: _went == true,
                    onPressed: () => setState(() => _went = true),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ChipButton(
                    label: 'No',
                    selected: _went == false,
                    onPressed: () => setState(() => _went = false),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (i) => IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
                  icon: Icon(
                    i < _stars ? Icons.star : Icons.star_border,
                    size: 34,
                    color: i < _stars ? AppColors.orange : Colors.black87,
                  ),
                  onPressed: () => setState(() => _stars = i + 1),
                ),
              ),
            ),

            _label('How were you feeling?'),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                for (final m in moods)
                  ChipButton(
                    label: m,
                    selected: _feeling == m,
                    onPressed: () =>
                        setState(() => _feeling = _feeling == m ? null : m),
                  ),
              ],
            ),

            _label('Good for'),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                for (final m in moods)
                  ChipButton(
                    label: m,
                    selected: _goodFor.contains(m),
                    onPressed: () => setState(() {
                      if (!_goodFor.remove(m)) _goodFor.add(m);
                    }),
                  ),
              ],
            ),

            _label('How was the price?'),
            Row(
              children: [
                for (final p in const ['Cheap', 'Fair', 'Expensive'])
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: p == 'Expensive' ? 0 : 8),
                      child: ChipButton(
                        label: p,
                        selected: _price == p,
                        onPressed: () => setState(() => _price = p),
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 20),
            PrimaryButton(label: 'Submit', onPressed: _submit),
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(foregroundColor: Colors.black87),
              child: const Text(
                'Skip',
                style: TextStyle(decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
