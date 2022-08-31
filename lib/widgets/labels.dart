import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  const Labels(
      {Key? key,
      required this.ruta,
      required this.question,
      required this.text})
      : super(key: key);

  final String ruta;
  final String question;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            question,
            style: const TextStyle(
                color: Colors.black54,
                fontSize: 15,
                fontWeight: FontWeight.w300),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: (() {
              Navigator.pushReplacementNamed(
                context,
                ruta,
              );
            }),
            child: Text(
              text,
              style: TextStyle(
                  color: Colors.blue[600],
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
