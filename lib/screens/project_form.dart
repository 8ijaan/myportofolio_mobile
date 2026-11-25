import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myportofolio_mobile/models/project.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _title = '';
  String _description = '';
  String _techStack = '';
  String _projectUrl = '';
  String _projectImageUrl = '';
  bool _isSubmitting = false;

  String? _validateRequired(String? value, String label) {
    if (value == null || value.trim().isEmpty) {
      return '$label cannot be empty!';
    }
    return null;
  }

  String? _validateUrl(String value) {
    final uri = Uri.tryParse(value);
    final isValid =
        uri != null &&
        !value.contains(' ') &&
        (uri.scheme == 'http' || uri.scheme == 'https') &&
        uri.host.isNotEmpty;

    return isValid ? null : 'Enter a valid URL (http:// or https://)!';
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    final loggedIn = await ensureLoggedIn(context);
    if (!loggedIn || !mounted) return;

    final auth = context.read<AuthState>();
    final apiClient = context.read<ApiClient>();
    final newProject = Project(
      title: _title,
      description: _description,
      techStack: _techStack,
      projectUrl: _projectUrl,
      projectImageUrl: _projectImageUrl,
    );

    setState(() {
      _isSubmitting = true;
    });

    try {
      final created = await apiClient.createProject(
        newProject,
        token: auth.token!,
      );
      if (!mounted) return;
      // Hentikan spinner sebelum dialog menutupi form.
      setState(() {
        _isSubmitting = false;
      });

      await _showSuccessDialog(created);
      if (mounted) _formKey.currentState!.reset();
    } on ApiException catch (e) {
      if (e.statusCode == 401) {
        // Token sudah tidak berlaku: hapus sesi lalu minta login ulang.
        await auth.logout();
        if (!mounted) return;
        _showError('Session expired, please log in again.');
        await ensureLoggedIn(context);
      } else {
        _showError('Failed to save project (status ${e.statusCode}).');
      }
    } on http.ClientException {
      _showError('Failed to save project: cannot reach the server.');
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  Future<void> _showSuccessDialog(Project project) {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Project successfully added!'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Title: ${project.title}'),
                Text('Description: ${project.description}'),
                Text('Tech Stack: ${project.techStack}'),
                Text('Project URL: ${project.projectUrl}'),
                if (project.projectImageUrl.isNotEmpty)
                  Text('Project Image URL: ${project.projectImageUrl}'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  InputDecoration _decoration(String label, String hint) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add Project Form')),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 16,
            children: [
              TextFormField(
                decoration: _decoration('Title', 'Project title'),
                onSaved: (value) => _title = value!.trim(),
                validator: (value) => _validateRequired(value, 'Title'),
              ),
              TextFormField(
                maxLines: 5,
                decoration: _decoration('Description', 'Project description'),
                onSaved: (value) => _description = value!.trim(),
                validator: (value) => _validateRequired(value, 'Description'),
              ),
              TextFormField(
                decoration: _decoration(
                  'Tech Stack',
                  'Example: Flutter, Django, Figma',
                ),
                onSaved: (value) => _techStack = value!.trim(),
                validator: (value) => _validateRequired(value, 'Tech Stack'),
              ),
              TextFormField(
                keyboardType: TextInputType.url,
                decoration: _decoration('Project URL', 'https://example.com'),
                onSaved: (value) => _projectUrl = value!.trim(),
                validator: (value) =>
                    _validateRequired(value, 'Project URL') ??
                    _validateUrl(value!.trim()),
              ),
              TextFormField(
                keyboardType: TextInputType.url,
                decoration: _decoration(
                  'Project Image URL (Optional)',
                  'https://example.com/image.png',
                ),
                onSaved: (value) => _projectImageUrl = value!.trim(),
                validator: (value) {
                  final url = value?.trim() ?? '';
                  return url.isEmpty ? null : _validateUrl(url);
                },
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _isSubmitting ? null : _submit,
                  child: _isSubmitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
