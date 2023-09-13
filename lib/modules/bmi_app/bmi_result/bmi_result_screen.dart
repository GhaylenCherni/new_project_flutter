import 'package:flutter/material.dart';

class BmiResultScreen extends StatelessWidget {

  final int result;
  final bool isMale;
  final int age;

  BmiResultScreen({
    required this.result, required this.isMale, required this.age,
});




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_left),
          onPressed: ()
          {
            Navigator.pop(context);
          },
        ),
        title: Text(
            'BMI Result',
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Gender : ${isMale ? 'MALE' : 'FEMALE'}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
              ),
            ),
            Text(
              'Result : $result',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
              ),
            ),
            Text(
              'Age : $age',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
