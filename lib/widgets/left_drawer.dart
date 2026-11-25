import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:provider/provider.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  /// Closes the drawer, then opens [page] only if the user is logged in.
  Future<void> _openProtected(BuildContext context, Widget page) async {
    // The drawer's context is gone once it closes, so use the navigator's.
    final navigator = Navigator.of(context);
    navigator.pop();

    final loggedIn = await ensureLoggedIn(navigator.context);
    if (!loggedIn) return;
    navigator.push(MaterialPageRoute<void>(builder: (_) => page));
  }

  Future<void> _login(BuildContext context) async {
    final navigator = Navigator.of(context);
    navigator.pop();
    await ensureLoggedIn(navigator.context);
  }

  Future<void> _logout(BuildContext context) async {
    final auth = context.read<AuthState>();
    final messenger = ScaffoldMessenger.of(context);
    Navigator.pop(context);

    await auth.logout();
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('Logged out.')));
  }

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = context.watch<AuthState>().isLoggedIn;

    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.indigo),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Portfolio',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Explore personal projects and experiences!',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            // Navigate to the portfolio home screen
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_circle_outline),
            title: const Text('Tambah Project'),
            // Navigate to the Add Project screen
            onTap: () => _openProtected(context, const ProjectFormPage()),
          ),
          ListTile(
            leading: const Icon(Icons.work_outline),
            title: const Text('Tambahkan Experience'),
            onTap: () => _openProtected(context, const ExperienceFormPage()),
          ),
          if (isLoggedIn)
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () => _logout(context),
            )
          else
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('Login'),
              onTap: () => _login(context),
            ),
        ],
      ),
    );
  }
}
