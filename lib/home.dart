import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:news_demo/backend/rss_to_json.dart';
import 'package:news_demo/screens/home/homepage.dart';
import 'package:news_demo/search/search.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;

  void changePage(int? index) {
    setState(() {
      currentIndex = index!;
    });
  }

  Map<String, List> newsData = <String, List>{};
  bool isLoading = true;
  getData() async {
    Future.wait([
      // rssToJson('portada'),
      // rssToJson('local'),
      // rssToJson('seguridad'),
      // rssToJson('negocios'),
      // rssToJson('internacional'),
      // rssToJson('cancha'),
      // rssToJson('gente'),
      // rssToJson('vida'),
      // rssToJson('ciencia'),
      // rssToJson('nacional'),
      // rssToJson('editoriales'),
      // rssToJson('gadgets'),
      // rssToJson('automotriz'),
      // rssToJson('moda'),
      // rssToJson('cdmx'),

      rssToJson('portada'),
      rssToJson('empresas'),
      rssToJson('economia'),
      rssToJson('nacional'),
      rssToJson('tecnologia'),
      rssToJson('carrera'),
      rssToJson('dinero'),
      rssToJson('emprendedores'),
      rssToJson('opinion'),
    ]).then((value) {
      value[0] = [];
      for (var element in value) {
        value[0].addAll([...element]);
      }
      value[0].shuffle();
      // newsData['portada'] = value[0].sublist(0, 10);
      // newsData['local'] = value[1];
      // newsData['seguridad'] = value[2];
      // newsData['negocios'] = value[3];
      // newsData['internacional'] = value[4];
      // newsData['cancha'] = value[5];
      // newsData['gente'] = value[6];
      // newsData['vida'] = value[7];
      // newsData['ciencia'] = value[8];
      // newsData['nacional'] = value[9];
      // newsData['editoriales'] = value[10];
      // newsData['gadgets'] = value[11];
      // newsData['automotriz'] = value[12];
      // newsData['moda'] = value[13];
      // newsData['cdmx'] = value[14];

      newsData['portada'] = value[0].sublist(0, 10);
      newsData['empresas'] = value[1];
      newsData['economia'] = value[2];
      newsData['nacional'] = value[3];
      newsData['tecnologia'] = value[4];
      newsData['carrera'] = value[5];
      newsData['dinero'] = value[6];
      newsData['emprendedores'] = value[7];
      newsData['opinion'] = value[8];
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {    
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              color:Colors.black, 
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
        backgroundColor:
            currentIndex == 1 ? const Color(0xffF7F8Fa) : Colors.white,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 0,
      ),
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width / 2.0,
        child: Drawer(
          backgroundColor: Colors.white,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 1,
              ),
              DrawerHeader(
                child: Container(
                  height: 142,
                  width: MediaQuery.of(context).size.width,
                  // child: const Icon(Icons.settings),
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
              GestureDetector(
                onTap: () {
                  setState(() {
                    currentIndex = 3;
                  });
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Iniciar sesión/registrarse",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  "Beneficios",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Version de lectura",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Alertas",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 300,
              ),
              Material(
                borderRadius: BorderRadius.circular(250),
                child: InkWell(
                  borderRadius: BorderRadius.circular(250),
                  splashColor: Colors.black45,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.black,
                    child: Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 25,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black,
                    child: const Center(
                      child: Text(
                        "v1.0.0",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xffffffff),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : <Widget>[
              HomePage(
                newsData: newsData,
              ),
              const Search(),
            ][currentIndex],
      bottomNavigationBar: BubbleBottomBar(
        opacity: 0,
        currentIndex: currentIndex,
        onTap: changePage,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 8,
        items: const <BubbleBottomBarItem>[
          BubbleBottomBarItem(
              backgroundColor: Color.fromRGBO(52, 73, 85, 1),
              icon: Icon(
                Icons.home,
                color: Color.fromRGBO(52, 73, 85, 1),
              ),
              activeIcon: Icon(
                Icons.home,
                color: Color.fromRGBO(249, 170, 51, 1),
              ),
              title: Text("Inicio")),
          BubbleBottomBarItem(
              backgroundColor: Color.fromRGBO(52, 73, 85, 1),
              icon: Icon(
                Icons.search,
                color: Color.fromRGBO(52, 73, 85, 1),
              ),
              activeIcon: Icon(
                Icons.search,
                color: Color.fromRGBO(249, 170, 51, 1),
              ),
              title: Text("Buscar"))
        ],
      ),
    );
  }
}
