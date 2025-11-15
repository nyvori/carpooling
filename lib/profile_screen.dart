import 'dart:io';
import 'package:flutter/material.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? imageFile; // lokalnie przechowywane zdjęcie
  String userName = "Jaro";
  String userSurname = "Krul";

  void _updateProfile(File? newImage, String newName, String newSurname) {
    setState(() {
      imageFile = newImage;
      userName = newName;
      userSurname = newSurname;

      // TUTAJ: opcjonalne pobranie aktualnych danych z backendu
      // Przykład:
      // UserProfile profile = await BackendService.getUserProfile();
      // imageFile = profile.image;
      // userName = profile.name;
      // userSurname = profile.surname;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      children: <Widget>[
        CircleAvatar(
          radius: 60,
          backgroundColor: Colors.blueAccent,
          backgroundImage: imageFile != null ? FileImage(imageFile!) : null,
          child: imageFile == null ? const Icon(Icons.person, size: 60, color: Colors.white) : null,
        ),
        const SizedBox(height: 12),
        Center(
          child: Text(
            '$userName $userSurname',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStatItem('Ocena', '4.9 ★'),
            _buildStatItem('Przejazdy', '102'),
            _buildStatItem('Jako kierowca', '35'),
          ],
        ),
        const SizedBox(height: 24),
        const Divider(indent: 16, endIndent: 16),
        ListTile(
          leading: const Icon(Icons.edit_outlined),
          title: const Text('Edytuj profil'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => EditProfileScreen(
                  currentImage: imageFile,
                  currentName: userName,
                  currentSurname: userSurname,
                ),
              ),
            );
            if (result != null) {
              _updateProfile(result['image'], result['name'], result['surname']);
            }
          },
        ),
        ListTile(
          leading: const Icon(Icons.directions_car_outlined),
          title: const Text('Moje pojazdy'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.settings_outlined),
          title: const Text('Ustawienia'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.help_outline),
          title: const Text('Pomoc i wsparcie'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {},
        ),
        const Divider(indent: 16, endIndent: 16),
        ListTile(
          leading: const Icon(Icons.logout, color: Colors.redAccent),
          title: const Text('Wyloguj', style: TextStyle(color: Colors.redAccent)),
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
      ],
    );
  }
}
