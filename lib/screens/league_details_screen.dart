import 'package:flutter/material.dart';
import './league_day_matches_screen.dart';
import './league_ranking_screen.dart';
import './league_table_screen.dart';
import './league_top_scorers_screen.dart';

class LeagueDetailsScreen extends StatefulWidget {
  static final String routeName = '/leaguedetailsscreen';

  @override
  _LeagueDetailsScreenState createState() => _LeagueDetailsScreenState();
}

class _LeagueDetailsScreenState extends State<LeagueDetailsScreen> {
  final PageStorageKey keyOne = PageStorageKey('leaguDayMatches');
  final PageStorageKey keyTwo = PageStorageKey('leagueRanking');
  final PageStorageKey keyThree = PageStorageKey('leagueTopScorers');
  final PageStorageKey keyFour = PageStorageKey('leagueTable');
  final PageStorageBucket storageBucket = PageStorageBucket();
  int _navigationIndex = 0;
  Widget currentPage;
  LeagueDayMatchesScreen dayMatchesScreen;
  LeagueRankingScreen rankingScreen;
  LeagueTopScorersScreen topScorersScreen;
  LeagueTableScreen tableScreen;
  List<Widget> pages;

  @override
  void initState() {
    super.initState();
    dayMatchesScreen = LeagueDayMatchesScreen(keyOne);
    rankingScreen = LeagueRankingScreen(keyTwo);
    topScorersScreen = LeagueTopScorersScreen(keyThree);
    tableScreen = LeagueTableScreen(keyFour);
    pages = [dayMatchesScreen, rankingScreen, topScorersScreen, tableScreen];
    currentPage = pages[_navigationIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: storageBucket,
        child: currentPage,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              backgroundColor: Colors.deepOrange,
              icon: Icon(Icons.calendar_today),
              title: Text('Today')),
          BottomNavigationBarItem(
              backgroundColor: Colors.deepOrange,
              icon: Icon(Icons.equalizer),
              title: Text('Ranking')),
          BottomNavigationBarItem(
            backgroundColor: Colors.deepOrange,
            icon: Icon(Icons.supervisor_account),
            title: Text('top scorers'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.deepOrange,
            icon: Icon(Icons.schedule),
            title: Text('table'),
          ),
        ],
        currentIndex: _navigationIndex,
        onTap: (value) {
          setState(() {
            _navigationIndex = value;
            currentPage = pages[_navigationIndex];
          });
        },
      ),
    );
  }
}