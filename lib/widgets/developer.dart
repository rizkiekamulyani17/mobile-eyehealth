import 'package:flutter/material.dart';

class Developer extends StatelessWidget {
  List developer = [
    "Rizki Eka Mulyani",
    "Fathur Rizqi Putra Pratama",
    "Muhammad Rafli Eriyanto",
    "Tengku Dimas Aditya"
  ];

  List<String> developerImages = [
    'assets/dev/rizki_eka_mulyani.jpeg',  
    'assets/dev/fathur_rizqi.jpeg',       
    'assets/dev/muhammad_rafli.jpeg',     
    'assets/dev/tengku_dimas.jpeg'        
  ];

  Developer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: developer.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) => Column(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey[300]!, width: 3),
              ),
              child: ClipOval(
                child: Image.asset(
                  developerImages[index],  // Displaying image
                  fit: BoxFit.cover,         // Make the image cover the circle area
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              developer[index],
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
