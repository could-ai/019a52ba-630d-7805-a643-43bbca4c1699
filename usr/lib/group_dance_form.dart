import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class GroupDanceForm extends StatefulWidget {
  const GroupDanceForm({super.key});

  @override
  State<GroupDanceForm> createState() => _GroupDanceFormState();
}

class _GroupDanceFormState extends State<GroupDanceForm> {
  final _formKey = GlobalKey<FormState>();
  String? _fileName;
  final List<TextEditingController> _memberControllers = [TextEditingController()];

  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3'],
    );

    if (result != null) {
      setState(() {
        _fileName = result.files.single.name;
      });
    }
  }

  void _addMemberField() {
    if (_memberControllers.length < 7) { // Team leader + 7 members = 8
      setState(() {
        _memberControllers.add(TextEditingController());
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Maximum of 8 participants allowed.')),
      );
    }
  }

  void _removeMemberField(int index) {
    if (_memberControllers.length > 1) {
      setState(() {
        _memberControllers.removeAt(index);
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _memberControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Group Dance Registration'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Team Name'),
                validator: (value) => value!.isEmpty ? 'Please enter a team name' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Team Leader Name'),
                validator: (value) => value!.isEmpty ? 'Please enter the team leader\'s name' : null,
              ),
              const SizedBox(height: 20),
              const Text('Team Members', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ..._buildMemberFields(),
              TextButton.icon(
                onPressed: _addMemberField,
                icon: const Icon(Icons.add),
                label: const Text('Add Member'),
              ),
               const Text(
                'Minimum 2 and maximum 8 participants.',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: _pickFile,
                    child: const Text('Upload Audio (MP3)'),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      _fileName ?? 'No file selected.',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'Max audio duration: 5 minutes.',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                     if (_memberControllers.length < 1) { // Leader + 1 member = 2
                       ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('A group must have at least 2 participants.')),
                      );
                      return;
                    }
                    if (_fileName == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please upload an audio file.')),
                      );
                      return;
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Registration Submitted!')),
                    );
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildMemberFields() {
    return List<Widget>.generate(_memberControllers.length, (index) {
      return Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _memberControllers[index],
              decoration: InputDecoration(labelText: 'Member ${index + 1} Name'),
              validator: (value) => value!.isEmpty ? 'Please enter member name' : null,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.remove_circle_outline),
            onPressed: () => _removeMemberField(index),
          ),
        ],
      );
    });
  }
}
