import 'package:flutter/material.dart';

/// Placeholder data so every screen has something to show.
/// Replace with your real data / backend later.

const List<String> moods = ['Sad', 'Stressed', 'Happy', 'Tired', 'Celebrating'];

const List<String> categories = [
  'Rice meals',
  'Burgers',
  'Desserts',
  'Soup',
  'Coffee',
  'Noodles',
];

class MenuItem {
  final String name;
  final int price;
  const MenuItem(this.name, this.price);
}

const Map<String, int> _defaultGoodFor = {
  'Sad': 50,
  'Stressed': 40,
  'Happy': 45,
  'Tired': 35,
  'Celebrating': 30,
};

class Place {
  final String name;
  final String cuisine;
  final int priceLevel; // 1 = P, 2 = PP, 3 = PPP
  final double distanceKm;
  final double rating;
  final int reviews;
  final bool openNow;
  final String hours;
  final String address;
  final Map<String, int> goodFor;
  final List<MenuItem> menu;

  const Place({
    required this.name,
    required this.priceLevel,
    required this.distanceKm,
    required this.rating,
    this.cuisine = 'Filipino Cuisine',
    this.reviews = 120,
    this.openNow = true,
    this.hours = '10:00 AM – 10:00 PM',
    this.address = 'Barangay Malinta, Valenzuela City, Metro Manila',
    this.goodFor = _defaultGoodFor,
    this.menu = const [],
  });
}

const List<Place> samplePlaces = [
  Place(
    name: 'Kusina Corner',
    priceLevel: 3,
    distanceKm: 1.2,
    rating: 4.2,
    goodFor: {'Happy': 60, 'Celebrating': 55, 'Stressed': 35},
    menu: [
      MenuItem('Kare-Kare', 260),
      MenuItem('Crispy Pata', 480),
      MenuItem('Sisig Rice Meal', 160),
    ],
  ),
  Place(
    name: 'Sinigang House',
    priceLevel: 3,
    distanceKm: 1.2,
    rating: 4.6,
    reviews: 236,
    address: '12 Mabini St., Barangay Malinta, Valenzuela City, Metro Manila',
    goodFor: {'Sad': 74, 'Stressed': 41, 'Happy': 32, 'Romantic': 18},
    menu: [
      MenuItem('Sinigang na Baboy', 215),
      MenuItem('Sinigang na Hipon', 255),
      MenuItem('Sinigang na Bangus', 230),
      MenuItem('Sinigang Rice Meal', 150),
    ],
  ),
  Place(
    name: 'Lutong Bahay',
    priceLevel: 3,
    distanceKm: 1.8,
    rating: 4.4,
    goodFor: {'Sad': 60, 'Tired': 55, 'Happy': 30},
  ),
  Place(
    name: 'Kusina ni Balong',
    priceLevel: 1,
    distanceKm: 2.4,
    rating: 4.2,
    goodFor: {'Tired': 62, 'Stressed': 45},
  ),
  Place(
    name: 'Bowl & Broth',
    priceLevel: 3,
    distanceKm: 3.1,
    rating: 4.5,
    goodFor: {'Sad': 58, 'Celebrating': 40},
  ),
  Place(name: 'Casa Kusina', priceLevel: 2, distanceKm: 2.0, rating: 4.3),
  Place(name: 'Timpla Ni Nanay', priceLevel: 1, distanceKm: 1.5, rating: 4.1),
  Place(name: 'Sabaw Stop', priceLevel: 2, distanceKm: 4.2, rating: 4.0),
];

/// First 4 of the sample places after "Kusina Corner" = the "sinigang" results.
final List<Place> sampleResults = samplePlaces.sublist(1, 5);

/// The "You may also like" row.
final List<Place> sampleSuggestions = samplePlaces.sublist(5);

IconData moodIcon(String mood) {
  switch (mood) {
    case 'Sad':
      return Icons.sentiment_dissatisfied_outlined;
    case 'Stressed':
      return Icons.mood_bad_outlined;
    case 'Happy':
      return Icons.sentiment_satisfied_alt_outlined;
    case 'Tired':
      return Icons.bedtime_outlined;
    case 'Celebrating':
      return Icons.celebration_outlined;
    case 'Romantic':
      return Icons.favorite_border;
    default:
      return Icons.sentiment_neutral_outlined;
  }
}
