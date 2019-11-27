import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../environment.dart';
import '../models/league.dart';
import '../models/country.dart';

class LeaguesProvider with ChangeNotifier {
  List<League> _leagues = [];

  // this will get wrong results for most of the year
  int _season = DateTime.now().year;

  List<League> get leagues => [..._leagues];

  _fetchCurrentSeason() async {
    http.Response response = await http.get(Environment.seasonUrl,
        headers: Environment.requestHeaders);
    Map<String, dynamic> res = json.decode(response.body);
    if (res['api']['results'].length < 1) {
      _season = DateTime.now().year;
    } else {
      List<int> _seasons = res['api']['seasons'];
      _season = _seasons[_seasons.length - 1];
    }
  }

  Future<List<League>> fetchLeaguesByCountry(Country country) async {
    // check if we have the current season
    // if (_season == null) await _fetchCurrentSeason();

    http.Response response = await http.get(
        Environment.leaguesUrl + '${country.code}/$_season',
        headers: Environment.requestHeaders);
    print('request url' +
        Environment.leaguesUrl +
        '${country.code}/${DateTime.now().year}');
    print(response.body.toString());
    Map<String, dynamic> res = json.decode(response.body);
    List<League> _fetchedLeagues = [];
    for (int i = 0; i < res['api']['leagues'].length; i++) {
      _fetchedLeagues.add(League.fromJson(res['api']['leagues'][i]));
    }
    return _fetchedLeagues;
  }

  addLeagueToFavorite(League league) {
    _leagues.add(league);
    notifyListeners();
  }

  removeLeagueFromFavorite(League league) {
    _leagues.removeWhere((League l) => l.leagueId == league.leagueId);
    notifyListeners();
  }

  isFavoriteLeague(int leagueId) {
    bool isFavorite = false;
    _leagues.forEach((League league) {
      if (leagueId == league.leagueId) isFavorite = true;
    });
    return isFavorite;
  }

  isLeagueFromCountry(String countryCode) {
    bool isFavorite = false;
    _leagues.forEach((League league) {
      if (league.countryCode == countryCode) isFavorite = true;
    });
    return isFavorite;
  }
}