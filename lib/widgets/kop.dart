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
            InkWell(onTap: (){
              Navigator.of(context).pop();
            },
              child: Image.asset(
                'images/logo.png',
                width: 80,
              ),
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
                    'Kauman RT 05 RW 01, Gemolong, Sragen',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    textAlign: TextAlign.justify,
                    'TELP:08578181929',
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
