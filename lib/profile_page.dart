import 'package:flutter/material.dart';
import 'app_style.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _name = 'Ka-FoodTRIP';
  String _email = 'kafoodtrip@email.com';
  int _budget = 2;
  bool _allowPersonalization = true;

  Future<void> _edit(
    String title,
    String current,
    ValueChanged<String> onSave,
  ) async {
    final controller = TextEditingController(text: current);
    final saved = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shape: roundedShape(),
        title: Text(title),
        content: TextField(
          controller: controller,
          autofocus: true,
          cursorColor: AppColors.grey,
          decoration: const InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.orange),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel',
                style: TextStyle(color: AppColors.greyDark)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, controller.text.trim()),
            child: const Text('Save',
                style: TextStyle(
                    color: AppColors.orange, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
    controller.dispose();
    if (saved != null && saved.isNotEmpty) onSave(saved);
  }

  Widget _group(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.greyLight),
        borderRadius: BorderRadius.circular(kRadius),
      ),
      child: Column(children: children),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: subPageAppBar('Profile and privacy'),
      body: ListView(
        padding: kPagePadding,
        children: [
          const Center(
            child: CircleAvatar(
              radius: 45,
              backgroundColor: AppColors.placeholder,
              child: Icon(Icons.person_outline,
                  size: 50, color: AppColors.greyDark),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              _name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.greyDark,
              ),
            ),
          ),
          const SizedBox(height: 20),

          _group([
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text('Name',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(_name),
              trailing: const Icon(Icons.edit_outlined, size: 20),
              onTap: () => _edit('Name', _name,
                  (v) => setState(() => _name = v)),
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.mail_outline),
              title: const Text('Email',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(_email),
              trailing: const Icon(Icons.edit_outlined, size: 20),
              onTap: () => _edit('Email', _email,
                  (v) => setState(() => _email = v)),
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.lock_outline),
              title: const Text('Change password',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Change password screen is not in the wireframe yet')),
              ),
            ),
          ]),
          const SizedBox(height: 15),

          // Usual budget
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.greyLight),
              borderRadius: BorderRadius.circular(kRadius),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Usual budget',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
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
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Allow personalization
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.sell_outlined),
            title: const Text('Allow personalization',
                style: TextStyle(fontWeight: FontWeight.bold)),
            trailing: Switch(
              value: _allowPersonalization,
              activeTrackColor: AppColors.orange,
              onChanged: (v) => setState(() => _allowPersonalization = v),
            ),
          ),
          const Text(
            'Use your mood tags and history to personalize recommendations.',
            style: TextStyle(color: AppColors.greyDark),
          ),
          const SizedBox(height: 20),

          OutlineActionButton(
            label: 'Delete my personalization data',
            icon: Icons.delete_outline,
            color: AppColors.danger,
            onPressed: () => confirmDeletePersonalization(context),
          ),
          const SizedBox(height: 15),
          OutlineActionButton(
            label: 'Log out',
            icon: Icons.logout,
            color: AppColors.greyDark,
            // Back to Home (the first route).
            onPressed: () =>
                Navigator.popUntil(context, (route) => route.isFirst),
          ),
        ],
      ),
    );
  }
}
