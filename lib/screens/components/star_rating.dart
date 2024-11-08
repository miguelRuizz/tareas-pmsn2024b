import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final double rating; // La calificación que recibes (por ejemplo, 7.609)

  StarRating({required this.rating});

  @override
  Widget build(BuildContext context) {
    // Convertimos la calificación de 10 puntos a una escala de 5 estrellas.
    double normalizedRating = rating / 2;

    // Redondeamos a la estrella más cercana.
    int fullStars = normalizedRating.round();

    // Crear una lista de iconos de estrella, según la calificación redondeada.
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Las estrellas
        ...List.generate(5, (index) {
          if (index < fullStars) {
            return Icon(Icons.star, color: Colors.yellow); // Estrella llena
          } else {
            return Icon(Icons.star_border, color: Colors.yellow); // Estrella vacía
          }
        }),
        // El texto del rating total
        SizedBox(width: 8), // Espaciado entre las estrellas y el texto
        Text(
          rating.toStringAsFixed(1), // Muestra el rating con un decimal
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}