import 'package:flutter/material.dart';
import 'package:pokedex/consts/consts_app.dart';
import 'package:pokedex/models/pokeapi.dart';
import 'package:pokedex/stores/pokeapi_store.dart';
import 'package:pokedex/widgets/app_bar_home.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    PokeApiStore pokeApiStore = PokeApiStore();
    pokeApiStore.fetchPokemonList();
    double screenWidth = MediaQuery.of(context).size.width;
    double statusWidth = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -(240 / 4.7),
            left: screenWidth - (240 / 1.6),
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(ConstsApp.blackPokeball, height: 240),
            ),
          ),
          Column(
            children: [
              SizedBox(height: statusWidth),
              const AppBarHome(),
              Expanded(
                child: Observer(
                  name: 'ListHomePage',
                  builder: (BuildContext context) {
                    PokeAPI pokeApi = pokeApiStore.pokeAPI;
                    if (pokeApi.pokemon == null) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return ListView.builder(
                      itemCount: pokeApi.pokemon!.length,
                      itemBuilder: (context, index) {
                        final pokemonName = pokeApi.pokemon![index].name ?? 'Unknown';
                        return ListTile(
                          title: Text(pokemonName),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
