import 'package:flutter/material.dart';
import 'app_style.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _hidden = true;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
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
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: kPagePadding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logo box
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.grey, width: 1),
                    borderRadius: BorderRadius.circular(kRadius),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Icon(Icons.location_on_outlined,
                          size: 60, color: AppColors.greyDark),
                      Transform.translate(
                        offset: const Offset(0, -6),
                        child: const Icon(Icons.restaurant,
                            size: 18, color: AppColors.greyDark),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),

                // FoodTRIP wordmark
                const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Food',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: 'TRIP',
                        style: TextStyle(color: AppColors.orange),
                      ),
                    ],
                  ),
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Valenzuela City',
                  style: TextStyle(fontSize: 14, color: AppColors.greyDark),
                ),
                const SizedBox(height: 30),

                AppTextField(
                  hint: 'Email',
                  icon: Icons.mail_outline,
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 15),
                AppTextField(
                  hint: 'Password',
                  icon: Icons.lock_outline,
                  controller: _password,
                  obscure: _hidden,
                  suffix: IconButton(
                    icon: Icon(
                      _hidden
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppColors.grey,
                    ),
                    onPressed: () => setState(() => _hidden = !_hidden),
                  ),
                ),
                const SizedBox(height: 25),

                // Design only: a real app would check the credentials first.
                PrimaryButton(
                  label: 'Login',
                  onPressed: () =>
                      Navigator.popUntil(context, (route) => route.isFirst),
                ),
                const SizedBox(height: 15),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(color: AppColors.greyDark),
                    ),
                    TextButton(
                      onPressed: () =>
                          ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Register screen is not in the wireframe yet'),
                        ),
                      ),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        foregroundColor: AppColors.orange,
                      ),
                      child: const Text(
                        'Register',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                const Divider(color: Color.fromARGB(255, 220, 220, 220)),
                const SizedBox(height: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shield_outlined,
                        size: 22, color: AppColors.greyDark),
                    SizedBox(width: 10),
                    Text(
                      'Users and admins use the same login',
                      style: TextStyle(fontSize: 13, color: AppColors.greyDark),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
