import 'package:comment_tree/data/comment.dart';
import 'package:dio/dio.dart';
import 'package:pmsn2024b/models/popular_moviedao.dart';

class PopularApi {

  final dio = Dio();
  final apiKey = '56b867dbd84f24723ef85a4adbe8d55e';
  final accountId = '21615525';
  final sessionId = 'a1fb2b23baa71b7560ab7df75c1e7f746656e96b';

  Future<List<PopularMovieDao>> getPopularMovies() async {
    final response = await dio.get('https://api.themoviedb.org/3/movie/popular?api_key=56b867dbd84f24723ef85a4adbe8d55e&language=es-MX&page=1');
    final res = response.data['results'] as List;
    //return res.map((popular) => PopularMovieDao.fromMap(popular)).toList();

    // Mapea cada película y establece 'isFavorite' usando isFavoriteMovie
    final popularMovies = await Future.wait(res.map((popular) async {
      final movie = PopularMovieDao.fromMap(popular);
      movie.isFavorite = await isFavorite(movie.id); // Asigna el estado de favorito
      return movie;
    }).toList());

    return popularMovies;
  }

  Future<List<Map<String, dynamic>>> fetchTrailersByMovie(int idMovie) async { 
    //final apiKey = '5019e68de7bc112f4e4337a500b96c56'; 
    final url = 'https://api.themoviedb.org/3/movie/$idMovie/videos?api_key=$apiKey&language=es-MX';
    List<Map<String, dynamic>> trailers = [];
    
    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final data = response.data;
        trailers = List<Map<String, dynamic>>.from(data['results']);
        trailers = trailers.where((video) => video['type'] == 'Trailer').toList();
        return trailers;
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error al obtener los datos: $e');
    }
    return trailers;
  }

  Future<List<PopularMovieDao>> getMyFavoriteMovies() async {
    final response = await dio.get('https://api.themoviedb.org/3/account/21615525/favorite/movies?api_key=56b867dbd84f24723ef85a4adbe8d55e&session_id=a1fb2b23baa71b7560ab7df75c1e7f746656e96b&language=es-MX');
    final res = response.data['results'] as List;
    return res.map((popular) => PopularMovieDao.fromMap(popular)).toList();
  }

  Future<bool> updateFavorites(int movieId, bool favorite) async {
    final url = 'https://api.themoviedb.org/3/account/$accountId/favorite';
    try {
      // Realiza la solicitud POST
      final response = await dio.post(
        url,
        queryParameters: {
          'api_key': apiKey,
          'session_id': sessionId,
        },
        data: {
          "media_type": "movie",
          "media_id": movieId,
          "favorite": favorite,
        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );

      // Verifica el código de estado de la respuesta
      if (response.statusCode == 200) {
        print('Película añadida a favoritos correctamente.');
        return true;
      } else {
        print('Error al añadir a favoritos: ${response.statusCode}');
        print(response.data);
      }
    } catch (e) {
      print('Error en la solicitud: $e');
    }
    return false;
  }

  Future<bool> isFavorite(int idMovie)async {
    final favoriteMovies = await getMyFavoriteMovies();
    return favoriteMovies.any((movie) => movie.id == idMovie);
  }

  Future<List<Map<String, dynamic>>> getMovieCast(int idMovie) async {
    final response = await dio.get('https://api.themoviedb.org/3/movie/$idMovie?api_key=$apiKey&language=es-MX&append_to_response=credits');
    //final res = response.data['credits']['cast'] as List;
    List<Map<String, dynamic>> cast = [];
    return cast = List<Map<String, dynamic>>.from(response.data['credits']['cast']);
    //return res.map((popular) => PopularMovieDao.fromMap(popular)).toList();
  }

  Future<List<Comment>> getMovieComments(int idMovie) async {
    final response = await dio.get('https://api.themoviedb.org/3/movie/$idMovie/reviews?api_key=$apiKey');

    final results = response.data['results'] as List;
    // return cast = List<Map<String, dynamic>>.from(response.data['results']);
    // Mapea los resultados de la API en objetos de tipo Comment
    return results.map((data) {
      return Comment(
        userName: data['author'],
        content: data['content'],
        avatar: data['author_details']['avatar_path'] ?? '',
      );
    }).toList();
  }
}