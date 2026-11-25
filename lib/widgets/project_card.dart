import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/screens/project_list_screen.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:provider/provider.dart';

class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _onTap(BuildContext context) async {
    _showMessage(context, "You pressed the ${item.name} button!");

    // Navigate ke halaman yang sesuai
    switch (item.name) {
      case "Lihat Project":
        _push(context, const ProjectListScreen());
      case "Tambah Project":
        await _pushProtected(context, const ProjectFormPage());
      case "Tambah Experience":
        await _pushProtected(context, const ExperienceFormPage());
      case "Logout":
        await _logout(context);
    }
  }

  void _push(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute<void>(builder: (_) => page));
  }

  Future<void> _pushProtected(BuildContext context, Widget page) async {
    final loggedIn = await ensureLoggedIn(context);
    if (!loggedIn || !context.mounted) return;
    _push(context, page);
  }

  Future<void> _logout(BuildContext context) async {
    final auth = context.read<AuthState>();
    if (!auth.isLoggedIn) {
      _showMessage(context, 'You are not logged in.');
      return;
    }

    await auth.logout();
    if (!context.mounted) return;
    _showMessage(context, 'Logged out.');
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () => _onTap(context),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, color: Colors.white, size: 30.0),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
