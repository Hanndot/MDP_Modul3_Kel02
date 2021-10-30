import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 15),
            child: Text(
              'Kelompok 02',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold, fontSize: 45),
            ),
          ),
        ),
        Text('M. Farhan Athaullah (21120119130072)')
      ],
    );
  }
}
