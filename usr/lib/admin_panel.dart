import 'package:flutter/material.dart';

class AdminPanel extends StatelessWidget {
  const AdminPanel({super.key});

  // Placeholder functions for export functionality
  void _exportSoloPdf(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Exporting Solo Registrations to PDF... (Not Implemented)')),
    );
  }

  void _exportSoloExcel(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Exporting Solo Registrations to Excel... (Not Implemented)')),
    );
  }

  void _exportGroupPdf(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Exporting Group Registrations to PDF... (Not Implemented)')),
    );
  }

  void _exportGroupExcel(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Exporting Group Registrations to Excel... (Not Implemented)')),
    );
  }

  void _exportAllAudio(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Exporting all audio files... (Not Implemented)')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            const Text(
              'Export Solo Registrations',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _exportSoloPdf(context),
                  icon: const Icon(Icons.picture_as_pdf),
                  label: const Text('Export to PDF'),
                ),
                ElevatedButton.icon(
                  onPressed: () => _exportSoloExcel(context),
                  icon: const Icon(Icons.table_chart),
                  label: const Text('Export to Excel'),
                ),
              ],
            ),
            const Divider(height: 40),
            const Text(
              'Export Group Registrations',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _exportGroupPdf(context),
                  icon: const Icon(Icons.picture_as_pdf),
                  label: const Text('Export to PDF'),
                ),
                ElevatedButton.icon(
                  onPressed: () => _exportGroupExcel(context),
                  icon: const Icon(Icons.table_chart),
                  label: const Text('Export to Excel'),
                ),
              ],
            ),
            const Divider(height: 40),
            const Text(
              'Export Audio Files',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton.icon(
                onPressed: () => _exportAllAudio(context),
                icon: const Icon(Icons.audiotrack),
                label: const Text('Export All Audio (ZIP)'),
                style: ElevatedButton.styleFrom(
                   padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
