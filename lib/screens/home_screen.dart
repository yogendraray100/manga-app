import 'package:flutter/material.dart';
import 'package:mangaapp/components/manga_card.dart';
import 'package:mangaapp/constants/constants.dart';
import 'package:mangaapp/widgets/BotNavItem.dart';
import 'package:web_scraper/web_scraper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedNavIndex = 0;
  bool mangaLoaded = false;

  List<Map<String, dynamic>> mangaList = [];

  void navBarTap(int index) {
    setState(() {
      selectedNavIndex = index;
    });
  }

  void fetchManga() async {
    final webscraper = WebScraper(Constants.baseUrl);
    if (await webscraper.loadWebPage('/www')) {
      mangaList = webscraper.getElement(
          'div.container-main-left > div.panel-content-homepage > div > a > img',
          ['src', 'alt']);
      print(mangaList);
      setState(() {
        mangaLoaded = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchManga();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Manga App"),
        backgroundColor: Constants.darkgray,
      ),
      body: mangaLoaded
          ? Container(
              height: screenSize.height,
              width: double.infinity,
              color: Constants.black,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Wrap(
                  runSpacing: 10,
                  spacing: 5,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 30,
                      padding: EdgeInsets.only(left: 10),
                      alignment: Alignment.center,
                      child: Text(
                        "${mangaList.length} mangas",
                        style: TextStyle(
                          fontSize: 23,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    for (int i = 0; i < mangaList.length; i++)
                      MangaCard(
                          mangaImg: mangaList[i]['attributes']['src'],
                          mangaTitle: mangaList[i]['attributes']['alt']),
                  ],
                ),
              ),
            )
          : Center(child: CircularProgressIndicator()),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Constants.darkgray,
          selectedItemColor: Constants.lightblue,
          unselectedItemColor: Colors.white,
          currentIndex: selectedNavIndex,
          onTap: navBarTap,
          items: [
            botNavItem(Icons.explore, "Explore"),
            botNavItem(Icons.recent_actors, "Recent"),
            botNavItem(Icons.favorite_outline, "Favourite"),
            botNavItem(Icons.more_horiz, "More"),
          ]),
    );
  }
}
