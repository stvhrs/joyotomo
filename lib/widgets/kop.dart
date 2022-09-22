import 'package:flutter/material.dart';

class Kop extends StatelessWidget {
  
  const Kop({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'images/logo.png',
              width: 80,
            ),
            SizedBox(
              width: 300,
              child: Column(
                children: const [
                  Text(
                    textAlign: TextAlign.justify,
                    'JOYOTOMO',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                        fontStyle: FontStyle.italic),
                  ),
                  Text(
                    textAlign: TextAlign.justify,
                    'Gemolong, Gandurejo, 4567',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    textAlign: TextAlign.justify,
                    'TELP:08578181929    FAX:10283211',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        // Divider(
        //   height: 10,
        //   thickness: 2.5,
        //   color: Colors.black,
        // ),
        // Divider(
        //   height: 1,
        //   color: Colors.black,
        //   thickness: 2.5,
        // )
      ],
    );
  }
}
