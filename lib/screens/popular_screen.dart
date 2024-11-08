import 'package:flutter/material.dart';
import 'package:pmsn2024b/models/popular_moviedao.dart';
import 'package:pmsn2024b/network/popular_api.dart';
import 'package:pmsn2024b/provider/test_provider.dart';
import 'package:provider/provider.dart';

class PopularScreen extends StatefulWidget {
  const PopularScreen({super.key});

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
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
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.pushNamed(
                context, 
                '/popfavmovies',
              );
            }
          ),
        ],
      ),
      body: FutureBuilder(
        future: popularApi!.getPopularMovies(),
        builder: (context, AsyncSnapshot<List<PopularMovieDao>> snapshot) {
          if (snapshot.hasData) {
            // Usamos addPostFrameCallback para evitar el error "setState during build"
            WidgetsBinding.instance.addPostFrameCallback((_) {
              final testProvider = Provider.of<TestProvider>(context, listen: false);
              testProvider.clearFavorites(); // Limpiar los favoritos antes de agregar nuevos

              // Filtra las películas favoritas y actualiza el provider con una lista de IDs
              final favoriteMovieIds = snapshot.data!
                  .where((movie) => movie.isFavorite) // Filtra las películas favoritas
                  .map((movie) => movie.id) // Extrae solo el ID de cada película
                  .toList(); // Convierte el iterable en una lista
              testProvider.addFavorites(favoriteMovieIds); // Añadir las películas favoritas al provider
            });

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
            return Consumer<TestProvider>(
              builder: (context, favoritesProvider, child) {
                final isFavorite = favoritesProvider.isFavorite(popular.id);

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
                            // Fondo negro semitransparente en la parte inferior con el título de la película
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Opacity(
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
                              ),
                            ),
                            // Ícono de corazón en la esquina superior derecha
                            Positioned(
                              top: 10,
                              right: 10,
                              child: GestureDetector(
                                onTap: () async {
                                  // Cambia el estado de favorito y llama a la función para añadir a favoritos
                                  // setState(() {
                                  //   isFavorite = !isFavorite;
                                  // });
                                  favoritesProvider.toggleFavorite(popular.id);
                                  await popularApi!.updateFavorites(popular.id, popular.isFavorite ? false : true); // Función que llama a la API para añadir a favoritos
                                  // Actualiza el estado para reflejar el cambio en la UI
                                },
                                child: Icon(
                                  isFavorite ? Icons.favorite : Icons.favorite_border,
                                  color: Colors.red,
                                  size: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
            );
          }
          return Center(child: CircularProgressIndicator()); // Muestra un indicador de carga mientras espera
        }
      }
    );
  }
}
