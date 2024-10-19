import 'package:flutter/material.dart';
import 'package:pmsn2024b/models/popular_moviedao.dart';
import 'package:pmsn2024b/network/popular_api.dart';

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
      body: FutureBuilder(
        future: popularApi!.getPopularMovies(),
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
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/popdetails', arguments: popular),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
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
    );
  }
}
