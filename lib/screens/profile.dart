import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final List nama = [
    "Anadda Ferrell Ramadhan",
    "Nisrina Shofa Nadifa",
    "Indriawan Muhammad Akbar",
    "M. Farhan Athaullah",
  ];
  final List nim = [
    "(21120119130035)",
    "(21120119120002)",
    "(21120119130070)",
    "(21120119130072)",
  ];

  ProfilePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
                title: Text(nama[index],
                    style: const TextStyle(color: Colors.white)),
                subtitle: Text(nim[index],
                    style: const TextStyle(color: Colors.white)),
                leading: CircleAvatar(
                  child: Text(nama[index][0],
                      style: const TextStyle(color: Colors.white)),
                )),
          );
        },
        itemCount: nama.length,
      ),
    );
  }
}
