import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pmsn2024b/screens/pr3-responsive/content_model.dart';

class Horizontal extends StatefulWidget {
  Horizontal({super.key, required this.content});

  OnboardingContent content;

  @override
  State<Horizontal> createState() => _HorizontalState();
}

class _HorizontalState extends State<Horizontal> {
  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Image.asset(
                widget.content.image!,
                height: currentHeight * .5,
              ),
            ]
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.content.title!,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.content.description!,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                )
              ]
            ),
          ),
        ],
      ),
    );
  }
}