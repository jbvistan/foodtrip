import 'package:flutter/material.dart';
import 'app_style.dart';
import 'details_page.dart';
import 'models.dart';

class ResultsPage extends StatefulWidget {
  final String query;
  const ResultsPage({super.key, this.query = 'sinigang'});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  static const _sorts = [
    'Best match',
    'Nearest',
    'Highest rated',
    'Lowest price',
  ];

  String _sort = _sorts.first;
  final Set<String> _filters = {};

  List<Place> get _results {
    var list = List<Place>.from(sampleResults);
    if (_filters.contains('Open now')) {
      list = list.where((p) => p.openNow).toList();
    }
    if (_filters.contains('Min rating')) {
      list = list.where((p) => p.rating >= 4.5).toList();
    }
    if (_filters.contains('Price')) {
      list = list.where((p) => p.priceLevel <= 2).toList();
    }
    if (_filters.contains('Distance')) {
      list = list.where((p) => p.distanceKm <= 2).toList();
    }
    switch (_sort) {
      case 'Nearest':
        list.sort((a, b) => a.distanceKm.compareTo(b.distanceKm));
        break;
      case 'Highest rated':
        list.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'Lowest price':
        list.sort((a, b) => a.priceLevel.compareTo(b.priceLevel));
        break;
    }
    return list;
  }

  void _openDetails(Place place) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetailsPage(place: place)),
    );
  }

  @override
  Widget build(BuildContext context) {
    const filterChips = <String, IconData>{
      'Location': Icons.place_outlined,
      'Price': Icons.sell_outlined,
      'Distance': Icons.straighten,
      'Open now': Icons.schedule,
      'Min rating': Icons.star_border,
    };
    final results = _results;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'Results for: ${widget.query}',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: kPagePadding,
        children: [
          // Filter chips (scroll sideways)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final entry in filterChips.entries) ...[
                  ChipButton(
                    label: entry.key,
                    icon: entry.value,
                    selected: _filters.contains(entry.key),
                    onPressed: () => setState(() {
                      if (!_filters.remove(entry.key)) _filters.add(entry.key);
                    }),
                  ),
                  const SizedBox(width: 8),
                ],
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Sort dropdown
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.greyLight),
              borderRadius: BorderRadius.circular(kRadius),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: _sort,
                icon: const Icon(Icons.keyboard_arrow_down),
                style: const TextStyle(fontSize: 14, color: Colors.black87),
                dropdownColor: Colors.white,
                items: [
                  for (final s in _sorts)
                    DropdownMenuItem(value: s, child: Text('Sort: $s')),
                ],
                onChanged: (v) => setState(() => _sort = v ?? _sort),
              ),
            ),
          ),
          const SizedBox(height: 12),

          if (results.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Center(
                child: Text(
                  'No suitable place found nearby',
                  style: TextStyle(color: AppColors.greyDark),
                ),
              ),
            )
          else
            for (final place in results)
              _ResultCard(place: place, onTap: () => _openDetails(place)),

          const SizedBox(height: 10),
          const Text(
            'You may also like',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.greyDark,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              for (var i = 0; i < sampleSuggestions.length; i++) ...[
                Expanded(
                  child: SizedBox(
                    height: 130,
                    child: PlaceMiniCard(
                      place: sampleSuggestions[i],
                      onTap: () => _openDetails(sampleSuggestions[i]),
                    ),
                  ),
                ),
                if (i < sampleSuggestions.length - 1) const SizedBox(width: 10),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  final Place place;
  final VoidCallback onTap;
  const _ResultCard({required this.place, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(kRadius),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.greyLight),
            borderRadius: BorderRadius.circular(kRadius),
          ),
          child: Row(
            children: [
              const PlaceholderImage(width: 90, height: 100),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      place.cuisine,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.greyDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Wrap(
                      spacing: 8,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          priceLabel(place.priceLevel),
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                        Text('${place.distanceKm} km',
                            style: const TextStyle(fontSize: 13)),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star, size: 14),
                            const SizedBox(width: 2),
                            Text('${place.rating}',
                                style: const TextStyle(fontSize: 13)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.orangeTint,
                        border: Border.all(color: AppColors.orange),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'Matches your craving',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.orange,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.greyDark),
            ],
          ),
        ),
      ),
    );
  }
}
