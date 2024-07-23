import 'package:mobx/mobx.dart';
import 'package:pokedex/consts/consts_api.dart';
import 'package:pokedex/models/pokeapi.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Certifique-se de importar isso para usar jsonDecode

part 'pokeapi_store.g.dart';

class PokeApiStore = PokeApiStoreBase with _$PokeApiStore;

abstract class PokeApiStoreBase with Store {
  @observable
  late PokeAPI pokeAPI;

  @action
  fetchPokemonList() {
    loadPokeAPI().then((pokeList) {
      if (pokeList != null) {
        pokeAPI = pokeList;
      }
    });
  }

  Future<PokeAPI?> loadPokeAPI() async {
    try {
      final response = await http.get(Uri.parse(ConstsAPI.pokeapiURL));
      if (response.statusCode == 200) {
        var decodeJson = jsonDecode(response.body);
        return PokeAPI.fromJson(decodeJson);
      } else {
        // Lidar com status de resposta diferente de 200
        return null;
      }
    } catch (error) {
      // ignore: avoid_print
      print("Erro ao carregar lista: $error");
      return null;
    }
  }
}
