import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/project.dart';

/// Shows every attribute of a single [Project].
class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({required this.project, super.key});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Detail'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Gambar hanya ditampilkan kalau URL-nya diisi.
            if (project.projectImageUrl.isNotEmpty) ...[
              Image.network(
                project.projectImageUrl,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Text('Failed to load image: ${project.projectImageUrl}'),
              ),
              const SizedBox(height: 16),
            ],
            Text(project.title, style: textTheme.headlineSmall),
            const SizedBox(height: 16),
            Text('Description', style: textTheme.titleMedium),
            Text(project.description),
            const SizedBox(height: 16),
            Text('Tech Stack', style: textTheme.titleMedium),
            Text(project.techStack),
            const SizedBox(height: 16),
            Text('Project URL', style: textTheme.titleMedium),
            SelectableText(project.projectUrl),
          ],
        ),
      ),
    );
  }
}
