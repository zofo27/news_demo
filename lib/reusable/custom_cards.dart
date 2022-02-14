import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:news_demo/home.dart';
import 'package:news_demo/login/login.dart';

class HomePageCard extends StatelessWidget {
  final String imageUrl, title, time, subtitle, content;

  const HomePageCard(
      {Key? key, required this.imageUrl, required this.title, required this.time, required this.subtitle, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 203,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xff707070),
                width: 1,
              ),
              image: DecorationImage(
                  image: Image.network(imageUrl).image, fit: BoxFit.fill),
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      color: Colors.black.withOpacity(0.33),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Center(
                      child: InkWell(
                        onTap: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailPageCard(title: title,content: content,imageUrl: imageUrl))),
                        child: Text(
                          subtitle,
                          style: const TextStyle(
                              fontFamily: "Avenir",
                              fontSize: 16,
                              color: Colors.white),
                          maxLines: 3,
                          overflow: TextOverflow.fade,
                        ),
                      ),

                      // child: Text(
                      //   subtitle ?? "",
                      //   style: const TextStyle(
                      //       fontFamily: "Avenir",
                      //       fontSize: 16,
                      //       color: Colors.white),
                      //   maxLines: 3,
                      //   overflow: TextOverflow.fade,
                      // ),


                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(time,
              style: const TextStyle(
                  fontFamily: "Times", fontSize: 13, color: Color(0xff8a8989))),
          const SizedBox(
            height: 7,
          ),
          Text(title,
              style: const TextStyle(
                  fontFamily: "League",
                  fontSize: 23,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class CategoriesCard extends StatelessWidget {
  final String imageUrl, category;

  const CategoriesCard(
      {Key? key, required this.imageUrl, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 114,
      width: 149,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
            image: AssetImage(imageUrl),
            colorFilter:
                const ColorFilter.mode(Colors.black38, BlendMode.overlay),
            fit: BoxFit.cover,
            alignment: Alignment.center),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 0.8, sigmaY: 0.8),
          child: Container(
              alignment: Alignment.center,
              color: Colors.black.withOpacity(.1),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: FittedBox(
                  child: Text(
                    category,
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}

class SearchCard extends StatelessWidget {
  final imageUrl, title, date;

  const SearchCard(
      {Key? key,
      this.imageUrl = "assets/images/categories/portada.jpg",
      this.title = "Noticia resultado de la busqueda",
      this.date = "10 Feb 2022"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 29),
      child: SizedBox(
        height: 106,
        child: Row(
          children: <Widget>[
            Container(
              height: 105,
              width: 155,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                image: DecorationImage(
                    image: AssetImage(imageUrl), fit: BoxFit.fill),
              ),
            ),
            const SizedBox(
              width: 6,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                  maxLines: 4,
                ),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xff8a8989),
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}

class DetailPageCard extends StatelessWidget {
  final String content, imageUrl, title;
  const DetailPageCard({Key? key, required this.content, required this.imageUrl, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    log("DetailPage title: " + title.toString());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const Home())),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 0,
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                  color: Colors.black12,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              Html(
                data: content.toString().substring(0, 200) + "....",
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.link),
                label: const Text('Registate o inicia sesion para seguir leyendo.'),
                onPressed: () => LoginScreen(),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.grey),
                    padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
                    textStyle:
                        MaterialStateProperty.all(const TextStyle(fontSize: 13))),
              ),
            ],
          )
        ],
      ),
    );
  }
}
