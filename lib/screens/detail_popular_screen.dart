import 'package:carousel_slider/carousel_slider.dart';
import 'package:comment_tree/comment_tree.dart';
import 'package:flutter/material.dart';
import 'package:pmsn2024b/models/popular_moviedao.dart';
import 'package:pmsn2024b/network/popular_api.dart';
import 'package:pmsn2024b/provider/test_provider.dart';
import 'package:pmsn2024b/screens/components/star_rating.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailPopularScreen extends StatefulWidget {
  const DetailPopularScreen({super.key});

  @override
  State<DetailPopularScreen> createState() => _DetailPopularScreenState();
}

class _DetailPopularScreenState extends State<DetailPopularScreen> {
  late Future<List<Comment>> commentsFuture;
  late YoutubePlayerController _ytController;
  PopularApi? popularApi;

  @override
  void initState() {
    super.initState();
    popularApi = PopularApi();
  }

  @override
  Widget build(BuildContext context) {
    // Está recuperando parámetros que se enviaron de una ruta nombrada
    //final popular = ModalRoute.of(context)!.settings.arguments as PopularMovieDao;
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final popular = arguments['popular'] as PopularMovieDao;
    final trailerKey = arguments['trailerKey'];
    TestProvider testProvider = Provider.of<TestProvider>(context);

    // Inicializa el controlador de YouTube
    _ytController = YoutubePlayerController(
      initialVideoId: trailerKey,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );

    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     testProvider.name = 'Drogas Baratas';
      //   },
      // ),
      body: SingleChildScrollView(
        child: Hero(
          tag: 'movie-poster-${popular.id}',
          child: Container(
            padding: EdgeInsets.all(25),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                opacity: .25,
                fit: BoxFit.fill,
                image: NetworkImage(
                    'https://image.tmdb.org/t/p/w500/${popular.posterPath}'
                )
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                YoutubePlayer( 
                  controller: _ytController, // Controler that we created earlier 
                  aspectRatio: 16 / 9,      // Aspect ratio you want to take in screen 
                ),
                SizedBox(height: 10,),
                Text(
                  popular.title.toUpperCase(), // Convierte el texto a mayúsculas
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold, // Hace el texto en negrita
                    fontSize: 24, // Cambia el tamaño de la fuente
                  ),
                ),
                SizedBox(height: 10,),
                StarRating(rating: popular.voteAverage),
                SizedBox(height: 10,),
                Text(
                  popular.overview, // Convierte el texto a mayúsculas
                  style: TextStyle(
                    fontWeight: FontWeight.normal, // Hace el texto en negrita
                    fontSize: 15, // Cambia el tamaño de la fuente
                  ),
                  maxLines: 5, // Limita el texto a 5 líneas
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 20,),
                Text(
                  'Reparto', // Convierte el texto a mayúsculas
                  style: TextStyle(
                    fontWeight: FontWeight.bold, // Hace el texto en negrita
                    fontSize: 20, // Cambia el tamaño de la fuente
                  ),
                ),
                SizedBox(height: 10,),
                FutureBuilder(
                  future: popularApi!.getMovieCast(popular.id), 
                  builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator()); // Muestra un indicador de carga mientras esperamos
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      final cast = snapshot.data!;
                      return movieCast(cast);
                    } else {
                      return Center(child: Text('No data available'));
                    }
                  }
                ),
                Text(
                  'Comentarios', // Convierte el texto a mayúsculas
                  style: TextStyle(
                    fontWeight: FontWeight.bold, // Hace el texto en negrita
                    fontSize: 20, // Cambia el tamaño de la fuente
                  ),
                ),
                SizedBox(height: 10,),
                // FutureBuilder(
                //   future: popularApi!.getMovieComments(popular.id), 
                //   builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                //     if (snapshot.connectionState == ConnectionState.waiting) {
                //       return Center(child: CircularProgressIndicator()); // Muestra un indicador de carga mientras esperamos
                //     } else if (snapshot.hasError) {
                //       return Center(child: Text('Error: ${snapshot.error}'));
                //     } else if (snapshot.hasData) {
                //       final comment = snapshot.data!;
                //       return Text('');//movieCast(cast);
                //     } else {
                //       return Center(child: Text('No data available'));
                //     }
                //   }
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget movieCast(cast) {
    return Container(
      child: CarouselSlider.builder(
        itemCount: cast.length,
        itemBuilder: (context, index, realIndex) {
          final actor = cast[index];
          return Column(
            children: [
              ClipOval(
                child: Image.network(
                  actor['profile_path'] != null ? 'https://image.tmdb.org/t/p/w500/${actor['profile_path']!}' : 'https://static.vecteezy.com/system/resources/previews/009/292/244/non_2x/default-avatar-icon-of-social-media-user-vector.jpg',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10),
              Text(
                actor['name']!,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                actor['character']!,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.normal),
              ),
            ],
          );
        },
        options: CarouselOptions(
          height: 250, // Ajusta la altura del carrusel
          enlargeCenterPage: true, // Aumenta el tamaño de la tarjeta en el centro
          viewportFraction: 0.35,
          enableInfiniteScroll: false, // Desactiva el desplazamiento infinito
          autoPlay: true, // Reproduce el carrusel automáticamente
          autoPlayInterval: Duration(seconds: 3), // Intervalo de cambio de imágenes
        ),
      )
    );
  }
}
