import 'package:flutter/material.dart';
import 'models.dart';

/// Colors and sizes taken straight from your main.dart so every screen matches.
class AppColors {
  static const orange = Color.fromARGB(255, 255, 122, 34);
  static const orangeTint = Color.fromARGB(26, 255, 122, 34);
  static const grey = Color.fromARGB(255, 133, 133, 133);
  static const greyDark = Color.fromARGB(255, 114, 114, 114);
  static const greyLight = Color.fromARGB(255, 158, 158, 158);
  static const greyButton = Color.fromARGB(221, 124, 124, 124);
  static const placeholder = Color.fromARGB(255, 235, 235, 235);
  static const danger = Color.fromARGB(255, 198, 40, 40);
}

const double kRadius = 10;
const EdgeInsets kPagePadding = EdgeInsets.all(15);

RoundedRectangleBorder roundedShape([double radius = kRadius]) =>
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius));

String priceLabel(int level) => '₱' * level;

/// White app bar with a bold centered title (same look as your Home app bar).
AppBar subPageAppBar(String title) {
  return AppBar(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: true,
    iconTheme: const IconThemeData(color: Colors.black),
    title: Text(
      title,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

/// Small grey bold heading, like "Most chosen" on Home.
class SectionLabel extends StatelessWidget {
  final String text;
  final double top;
  const SectionLabel(this.text, {super.key, this.top = 30});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: top, bottom: 10),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: AppColors.greyLight,
        ),
      ),
    );
  }
}

/// The outlined rounded button used for chips/toggles (grey = off, orange = on).
class ChipButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback? onPressed;
  final IconData? icon;

  const ChipButton({
    super.key,
    required this.label,
    this.selected = false,
    this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.orange : AppColors.greyButton;
    final style = OutlinedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      foregroundColor: color,
      backgroundColor: selected ? AppColors.orangeTint : Colors.white,
      side: BorderSide(color: color, width: 1),
      shape: roundedShape(),
    );
    if (icon != null) {
      return OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 18),
        label: Text(label),
        style: style,
      );
    }
    return OutlinedButton(
      onPressed: onPressed,
      style: style,
      child: Text(label),
    );
  }
}

/// Solid orange button (Login / Roll / Submit / Open in Maps).
class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool fullWidth;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.fullWidth = true,
  });

  @override
  Widget build(BuildContext context) {
    final button = ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.only(top: 15, bottom: 15),
        backgroundColor: AppColors.orange,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: roundedShape(),
      ),
      child: Text(label),
    );
    return fullWidth ? SizedBox(width: double.infinity, child: button) : button;
  }
}

/// White button with a colored outline (Sign Up / Roll again / Log out / Delete).
class OutlineActionButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color color;
  final IconData? icon;

  const OutlineActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color = AppColors.grey,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final style = OutlinedButton.styleFrom(
      padding: const EdgeInsets.only(top: 15, bottom: 15),
      backgroundColor: Colors.white,
      foregroundColor: color,
      side: BorderSide(color: color, width: 1),
      shape: roundedShape(),
    );
    final button = icon == null
        ? OutlinedButton(onPressed: onPressed, style: style, child: Text(label))
        : OutlinedButton.icon(
            onPressed: onPressed,
            icon: Icon(icon, size: 20),
            label: Text(label),
            style: style,
          );
    return SizedBox(width: double.infinity, child: button);
  }
}

/// Bordered text field matching the search bar on Home.
class AppTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final TextEditingController? controller;
  final bool obscure;
  final Widget? suffix;
  final ValueChanged<String>? onSubmitted;
  final TextInputType? keyboardType;

  const AppTextField({
    super.key,
    required this.hint,
    required this.icon,
    this.controller,
    this.obscure = false,
    this.suffix,
    this.onSubmitted,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey, width: 1),
        borderRadius: BorderRadius.circular(kRadius),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.grey),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscure,
              keyboardType: keyboardType,
              onSubmitted: onSubmitted,
              cursorColor: AppColors.grey,
              style: const TextStyle(color: AppColors.grey),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle:
                    const TextStyle(fontSize: 14, color: AppColors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
          if (suffix != null) suffix!,
        ],
      ),
    );
  }
}

/// Personalized / Discovery toggle.
class ModeToggle extends StatelessWidget {
  final bool personalizedActive;
  final VoidCallback onPersonalized;
  final VoidCallback onDiscovery;

  const ModeToggle({
    super.key,
    required this.personalizedActive,
    required this.onPersonalized,
    required this.onDiscovery,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ChipButton(
            label: 'Personalized mode',
            selected: personalizedActive,
            onPressed: onPersonalized,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ChipButton(
            label: 'Discovery mode',
            selected: !personalizedActive,
            onPressed: onDiscovery,
          ),
        ),
      ],
    );
  }
}

/// Grey box standing in for a photo.
class PlaceholderImage extends StatelessWidget {
  final double? width;
  final double? height;
  final double radius;

  const PlaceholderImage({super.key, this.width, this.height, this.radius = 8});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.placeholder,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: const Center(
        child: Icon(Icons.image_outlined, color: AppColors.greyLight, size: 32),
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  final double rating;
  final double size;
  const StarRating({super.key, required this.rating, this.size = 16});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        5,
        (i) => Icon(
          i < rating.round() ? Icons.star : Icons.star_border,
          size: size,
          color: Colors.black87,
        ),
      ),
    );
  }
}

/// Small photo-on-top card ("Recommended for you", "You may also like").
/// Give it a height from the parent (SizedBox).
class PlaceMiniCard extends StatelessWidget {
  final Place place;
  final VoidCallback? onTap;
  const PlaceMiniCard({super.key, required this.place, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(kRadius),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.greyLight),
          borderRadius: BorderRadius.circular(kRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: PlaceholderImage(width: double.infinity, radius: 0),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    place.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    place.cuisine,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.greyDark,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// "This removes your mood tags and history. Delete?" confirmation.
Future<void> confirmDeletePersonalization(BuildContext context) async {
  final messenger = ScaffoldMessenger.of(context);
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shape: roundedShape(),
      content: const Text('This removes your mood tags and history. Delete?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: const Text('Cancel',
              style: TextStyle(color: AppColors.greyDark)),
        ),
        TextButton(
          onPressed: () => Navigator.pop(ctx, true),
          child: const Text(
            'Delete',
            style: TextStyle(
              color: AppColors.danger,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
  if (confirmed == true) {
    messenger.showSnackBar(
      const SnackBar(content: Text('Personalization data deleted')),
    );
  }
}
