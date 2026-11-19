import 'package:flutter/material.dart';
import 'app_style.dart';
import 'details_page.dart';
import 'models.dart';
import 'profile_page.dart';
import 'results_page.dart';

class PersonalizedHomePage extends StatefulWidget {
  const PersonalizedHomePage({super.key});

  @override
  State<PersonalizedHomePage> createState() => _PersonalizedHomePageState();
}

class _PersonalizedHomePageState extends State<PersonalizedHomePage> {
  final _search = TextEditingController();

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  void _goToResults(String text) {
    final query = text.trim().isEmpty ? 'all food' : text.trim();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ResultsPage(query: query)),
    );
  }

  void _openSettings() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const PersonalizationSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Column(
          children: [
            Text(
              'FoodTRIP',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Valenzuela City',
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Personalization settings',
            icon: const Icon(Icons.filter_alt_outlined),
            onPressed: _openSettings,
          ),
          IconButton(
            tooltip: 'Profile',
            icon: const Icon(Icons.person_outline),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfilePage()),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: kPagePadding,
        children: [
          ModeToggle(
            personalizedActive: true,
            onPersonalized: () {},
            // Discovery mode is the Home screen, which is the first route.
            onDiscovery: () => Navigator.pop(context),
          ),
          const SizedBox(height: 20),
          const Text(
            'Hi, Ka-FoodTRIP!',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: AppColors.greyDark,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'What are you craving today?',
            style: TextStyle(fontSize: 16, color: AppColors.greyDark),
          ),
          const SizedBox(height: 20),
          AppTextField(
            hint: 'Search for food, places, or cuisines',
            icon: Icons.search,
            controller: _search,
            onSubmitted: _goToResults,
          ),
          const SectionLabel('Recommended for you'),
          SizedBox(
            height: 160,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: samplePlaces.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, i) => SizedBox(
                width: 140,
                child: PlaceMiniCard(
                  place: samplePlaces[i],
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailsPage(place: samplePlaces[i]),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// The "Personalization settings" bottom sheet.
class PersonalizationSheet extends StatefulWidget {
  const PersonalizationSheet({super.key});

  @override
  State<PersonalizationSheet> createState() => _PersonalizationSheetState();
}

class _PersonalizationSheetState extends State<PersonalizationSheet> {
  String? _mood;
  int? _budget;
  final Set<String> _favorites = {};

  Widget _label(String text) => Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 8),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: AppColors.greyDark,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.greyLight,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Personalization settings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            _label('How are you feeling?'),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final m in moods)
                  ChipButton(
                    label: m,
                    selected: _mood == m,
                    onPressed: () =>
                        setState(() => _mood = _mood == m ? null : m),
                  ),
              ],
            ),

            const Divider(height: 30),
            _label('Usual budget'),
            Row(
              children: [
                for (var level = 1; level <= 3; level++) ...[
                  Expanded(
                    child: ChipButton(
                      label: priceLabel(level),
                      selected: _budget == level,
                      onPressed: () => setState(() => _budget = level),
                    ),
                  ),
                  if (level < 3) const SizedBox(width: 10),
                ],
              ],
            ),

            const Divider(height: 30),
            _label('Favorite categories'),
            GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                for (final c in categories)
                  ChipButton(
                    label: c,
                    selected: _favorites.contains(c),
                    onPressed: () => setState(() {
                      if (!_favorites.remove(c)) _favorites.add(c);
                    }),
                  ),
              ],
            ),

            const Divider(height: 30),
            OutlineActionButton(
              label: 'Delete my personalization data',
              color: AppColors.danger,
              onPressed: () => confirmDeletePersonalization(context),
            ),
          ],
        ),
      ),
    );
  }
}
