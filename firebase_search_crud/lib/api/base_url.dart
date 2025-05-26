class ApiUrl {
  static String apiBaseUrl = 'https://pokeapi.co/api/v2/pokemon/';

  static String getPokemonPagination({required int limit, required int offset}) {
    return '$apiBaseUrl?offset=$offset&limit=$limit';
  }

  // static String getPokemonDefault() {
  //   return '${apiBaseUrl}?limit=10';
  // }
}
