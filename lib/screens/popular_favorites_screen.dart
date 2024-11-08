import 'package:flutter/material.dart';
import 'package:pmsn2024b/models/popular_moviedao.dart';
import 'package:pmsn2024b/network/popular_api.dart';

class PopularFavoritesScreen extends StatefulWidget {
  const PopularFavoritesScreen({super.key});

  @override
  State<PopularFavoritesScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularFavoritesScreen> {
  PopularApi? popularApi;

  @override
  void initState() {
    super.initState();
    popularApi = PopularApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Lista de Favoritos'),
      ),
      body: FutureBuilder(
        future: popularApi!.getMyFavoriteMovies(),
        builder: (context, AsyncSnapshot<List<PopularMovieDao>> snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              itemCount: snapshot.data!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Cuántas columnas ocupa mi grid
                childAspectRatio: .7,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10
              ),
              itemBuilder: (context, index) {
                return cardPopular(snapshot.data![index]);
              },
            );
          } else {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Something was wrong :()'),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        },
      ),
    );
  }

  Widget cardPopular(PopularMovieDao popular) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: popularApi!.fetchTrailersByMovie(popular.id), // Llama a tu API
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}')); // Muestra un mensaje de error si ocurre un error
        } else {
          if(snapshot.hasData) {
            final movieTrailerKey = snapshot.data!.isNotEmpty ? snapshot.data!.first['key'] : ''; // Accede al primer trailer y a su 'key'

            return GestureDetector(
              onTap: () => Navigator.pushNamed(
                context, 
                '/popdetails', 
                arguments: {
                  'popular': popular,
                  'trailerKey': movieTrailerKey,
                }
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Hero(
                  tag: 'movie-poster-${popular.id}',
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage('https://image.tmdb.org/t/p/w500/${popular.posterPath}'),
                      )
                    ),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Opacity(
                          opacity: .7,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            color: Colors.black,
                            height: 50,
                            
                            child: Text(
                              popular.title,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return Center(child: CircularProgressIndicator()); // Muestra un indicador de carga mientras espera
        }
      }
    );
  }
}
