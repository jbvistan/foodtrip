import 'dart:math';

import 'package:flutter/material.dart';
import 'app_style.dart';
import 'details_page.dart';
import 'feedback_dialog.dart';
import 'models.dart';

class SurpriseMePage extends StatefulWidget {
  const SurpriseMePage({super.key});

  @override
  State<SurpriseMePage> createState() => _SurpriseMePageState();
}

class _SurpriseMePageState extends State<SurpriseMePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _spin = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 700),
  );
  final _random = Random();

  int? _budget; // 1..3
  double? _maxKm;
  String? _mood;

  Place? _result;
  bool _rolled = false;
  bool _rolling = false;

  @override
  void dispose() {
    _spin.dispose();
    super.dispose();
  }

  Future<void> _roll() async {
    if (_rolling) return;
    setState(() => _rolling = true);
    await _spin.forward(from: 0);
    if (!mounted) return;

    final options = samplePlaces.where((p) {
      final budgetOk = _budget == null || p.priceLevel <= _budget!;
      final distanceOk = _maxKm == null || p.distanceKm <= _maxKm!;
      final moodOk = _mood == null || (p.goodFor[_mood] ?? 0) >= 30;
      return budgetOk && distanceOk && moodOk;
    }).toList();

    setState(() {
      _rolling = false;
      _rolled = true;
      _result =
          options.isEmpty ? null : options[_random.nextInt(options.length)];
    });
  }

  Future<T?> _pick<T>(String title, Map<String, T> options) {
    return showModalBottomSheet<T>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            for (final e in options.entries)
              ListTile(
                title: Text(e.key),
                onTap: () => Navigator.pop(ctx, e.value),
              ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Future<void> _chooseBudget() async {
    final v = await _pick<int>('Budget', {
      'Any budget': 0,
      '₱': 1,
      '₱₱': 2,
      '₱₱₱': 3,
    });
    if (v != null) setState(() => _budget = v == 0 ? null : v);
  }

  Future<void> _chooseDistance() async {
    final v = await _pick<double>('Distance', {
      'Any distance': 0,
      'Within 1 km': 1,
      'Within 2 km': 2,
      'Within 3 km': 3,
      'Within 5 km': 5,
    });
    if (v != null) setState(() => _maxKm = v == 0 ? null : v);
  }

  Future<void> _chooseMood() async {
    final v = await _pick<String>('Mood (optional)', {
      'Any mood': '',
      for (final m in moods) m: m,
    });
    if (v != null) setState(() => _mood = v.isEmpty ? null : v);
  }

  /// "Choose this": open the place, and when you come back, ask how it went.
  /// (In the real app that pop-up would appear on Home after the visit.)
  Future<void> _choose(Place place) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetailsPage(place: place)),
    );
    if (!mounted) return;
    showVisitFeedback(context, place.name);
  }

  @override
  Widget build(BuildContext context) {
    final place = _result;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: subPageAppBar('Surprise me'),
      body: SingleChildScrollView(
        padding: kPagePadding,
        child: Column(
          children: [
            // Filters
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ChipButton(
                    label: _budget == null ? 'Budget' : priceLabel(_budget!),
                    icon: Icons.account_balance_wallet_outlined,
                    selected: _budget != null,
                    onPressed: _chooseBudget,
                  ),
                  const SizedBox(width: 8),
                  ChipButton(
                    label: _maxKm == null
                        ? 'Distance'
                        : '≤ ${_maxKm!.toStringAsFixed(0)} km',
                    icon: Icons.place_outlined,
                    selected: _maxKm != null,
                    onPressed: _chooseDistance,
                  ),
                  const SizedBox(width: 8),
                  ChipButton(
                    label: _mood ?? 'Mood (optional)',
                    icon: Icons.sentiment_satisfied_alt_outlined,
                    selected: _mood != null,
                    onPressed: _chooseMood,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // Dice
            RotationTransition(
              turns: _spin,
              child: const Icon(Icons.casino_outlined,
                  size: 140, color: AppColors.greyDark),
            ),
            const SizedBox(height: 10),
            const Text(
              "Can't decide? Roll the dice.",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.greyDark,
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: 170,
              child: PrimaryButton(
                label: _rolling ? 'Rolling...' : 'Roll',
                onPressed: _rolling ? null : _roll,
              ),
            ),
            const SizedBox(height: 20),

            // Result
            if (place != null) ...[
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.greyLight),
                  borderRadius: BorderRadius.circular(kRadius),
                ),
                child: Row(
                  children: [
                    const PlaceholderImage(width: 110, height: 120),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            place.name,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(place.cuisine,
                              style: const TextStyle(
                                  color: AppColors.greyDark)),
                          const SizedBox(height: 4),
                          Text(priceLabel(place.priceLevel),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.location_on, size: 16),
                              const SizedBox(width: 4),
                              Text('${place.distanceKm} km'),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              StarRating(rating: place.rating),
                              const SizedBox(width: 8),
                              Text('${place.rating}'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      label: 'Choose this',
                      onPressed: () => _choose(place),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlineActionButton(
                      label: 'Roll again',
                      color: AppColors.greyDark,
                      onPressed: _rolling ? null : _roll,
                    ),
                  ),
                ],
              ),
            ] else if (_rolled)
              const Column(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.location_off_outlined,
                        color: AppColors.greyDark),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'No suitable place found nearby',
                    style: TextStyle(color: AppColors.greyDark),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
