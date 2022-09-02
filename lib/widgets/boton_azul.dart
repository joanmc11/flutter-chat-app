import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {
  const BotonAzul({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(2),
        shape: MaterialStateProperty.all(const StadiumBorder()),
        backgroundColor: MaterialStateProperty.all(
            onPressed == null ? Colors.grey : Colors.blue),
      ),
      onPressed: onPressed,
      child: SizedBox(
          width: double.infinity,
          height: 55,
          child: Center(
            child: Text(text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                )),
          )),
    );
  }
}
