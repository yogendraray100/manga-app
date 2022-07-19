import 'package:flutter/material.dart';
import 'package:mangaapp/constants/constants.dart';

class MangaCard extends StatelessWidget {
  final String mangaImg, mangaTitle;
  const MangaCard({Key? key, required this.mangaImg, required this.mangaTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 110,
      child: Column(
        children: [
          Expanded(
            flex: 75,
            child: Container(
              child: Image.network(
                mangaImg,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 25,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                mangaTitle,
                style: TextStyle(color: Colors.white),
              ),
              color: Constants.darkgray,
            ),
          ),
        ],
      ),
    );
  }
}
