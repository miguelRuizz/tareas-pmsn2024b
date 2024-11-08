class Comment {
  final int id;
  final String username;
  final String content;
  final String avatarPath;
  final double rating;
  final List<Comment> replies; // Para los comentarios hijos (respuestas)

  Comment({
    required this.id,
    required this.username,
    required this.content,
    required this.avatarPath,
    required this.rating,
    this.replies = const [], // Por defecto, sin respuestas
  });
}