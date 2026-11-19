import 'package:flutter/material.dart';
import 'app_style.dart';
import 'models.dart';

class DetailsPage extends StatelessWidget {
  final Place place;
  const DetailsPage({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    final goodFor = place.goodFor.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header photo + back button
                  Stack(
                    children: [
                      Container(
                        height: 230,
                        width: double.infinity,
                        color: AppColors.placeholder,
                        child: const Icon(Icons.image_outlined,
                            size: 64, color: AppColors.greyLight),
                      ),
                      SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Material(
                            color: Colors.white,
                            elevation: 1,
                            borderRadius: BorderRadius.circular(kRadius),
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding: kPagePadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          place.name,
                          style: const TextStyle(
                              fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            StarRating(rating: place.rating, size: 20),
                            const SizedBox(width: 8),
                            Text('${place.rating} (${place.reviews})'),
                            const SizedBox(width: 10),
                            const Text('|',
                                style: TextStyle(color: AppColors.grey)),
                            const SizedBox(width: 10),
                            Text(
                              priceLabel(place.priceLevel),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: AppColors.orangeTint,
                                border: Border.all(color: AppColors.orange),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                place.openNow ? 'Open now' : 'Closed',
                                style: const TextStyle(
                                  color: AppColors.orange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text('•  ${place.hours}'),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.location_on_outlined, size: 20),
                            const SizedBox(width: 8),
                            Expanded(child: Text(place.address)),
                          ],
                        ),

                        const Divider(height: 30),
                        const Text('Good for',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              for (final e in goodFor)
                                Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 8),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.greyButton),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(moodIcon(e.key),
                                          size: 18,
                                          color: AppColors.greyDark),
                                      const SizedBox(width: 6),
                                      Text('${e.key} ${e.value}%',
                                          style: const TextStyle(fontSize: 13)),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),

                        const Divider(height: 30),
                        const Text('Menu',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        if (place.menu.isEmpty)
                          const Text('Menu coming soon',
                              style: TextStyle(color: AppColors.greyDark))
                        else
                          for (final item in place.menu)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Row(
                                children: [
                                  const PlaceholderImage(
                                      width: 38, height: 38, radius: 4),
                                  const SizedBox(width: 12),
                                  Expanded(child: Text(item.name)),
                                  Text('₱${item.price}'),
                                ],
                              ),
                            ),

                        const Divider(height: 30),
                        // Static map stand-in. Swap for google_maps_flutter or
                        // flutter_map when you're ready for a real map.
                        Container(
                          height: 140,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.placeholder,
                            borderRadius: BorderRadius.circular(kRadius),
                          ),
                          child: const Icon(Icons.location_on,
                              size: 42, color: AppColors.greyDark),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Sticky bottom button
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 8, 15, 12),
              child: PrimaryButton(
                label: 'Open in Maps',
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Opening ${place.name} in Maps...')),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
