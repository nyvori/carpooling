import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  final File? currentImage;
  final String currentName;
  final String currentSurname;

  const EditProfileScreen({
    super.key,
    this.currentImage,
    required this.currentName,
    required this.currentSurname,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _surnameController;
  File? imageFile;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentName);
    _surnameController = TextEditingController(text: widget.currentSurname);
    imageFile = widget.currentImage;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edytuj profil')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.blueAccent,
              backgroundImage: imageFile != null ? FileImage(imageFile!) : null,
              child: imageFile == null ? const Icon(Icons.person, size: 60, color: Colors.white) : null,
            ),
            TextButton.icon(
              icon: const Icon(Icons.photo_library),
              label: const Text('Wybierz zdjęcie'),
              onPressed: _pickImage,
            ),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Imię'),
            ),
            TextField(
              controller: _surnameController,
              decoration: const InputDecoration(labelText: 'Nazwisko'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // TUTAJ: miejsce na backend do zapisu zdjęcia i danych
                // await BackendService.updateUserProfile(imageFile, _nameController.text, _surnameController.text);

                // Tymczasowo zapis lokalny
                Navigator.pop(context, {
                  'image': imageFile,
                  'name': _nameController.text,
                  'surname': _surnameController.text,
                });
              },
              child: const Text('Zapisz'),
            ),
          ],
        ),
      ),
    );
  }
}
