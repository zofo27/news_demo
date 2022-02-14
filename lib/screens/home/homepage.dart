import 'package:flutter/material.dart';
import '../../model/categories_model.dart';
import '../../reusable/custom_cards.dart';
//import 'package:news_demo/utils.dart';

class HomePage extends StatefulWidget {
  final Map<String, List> newsData;

  const HomePage({Key? key, required this.newsData}) : super(key: key);
  @override
 
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late TabController _tabController;
  int currentIndex = 0;

  Map<String, List> _newsData = <String, List>{};

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _tabController = TabController(length: categories.length, vsync: this);
    _tabController.addListener(_smoothScrollToTop);
    setState(() {
      _newsData = Map.from(widget.newsData);
    });
  }

  _smoothScrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(microseconds: 300),
      curve: Curves.ease,
    );
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, value) {
          return [
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(25, 10, 25, 25),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "El Horizonte",
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.only(left: 25),
                alignment: Alignment.centerLeft,
                child: TabBar(
                    labelPadding: const EdgeInsets.only(right: 15),
                    indicatorSize: TabBarIndicatorSize.label,
                    controller: _tabController,
                    isScrollable: true,
                    indicator: const UnderlineTabIndicator(),
                    labelColor: Colors.black,
                    labelStyle:
                        const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                    unselectedLabelColor: Colors.black45,
                    unselectedLabelStyle:
                        const TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                    tabs: List.generate(categories.length,
                        (index) => Text(categories[index].name))),
              ),
            ),
          ];
        },
        body: TabBarView(
            controller: _tabController,
            children: List.generate(categories.length, (index) {
              var key = categories[index]
                  .imageUrl
                  .toString()
                  .split("/")[3]
                  .split(".")[0]
                  .replaceAll("_", "-");
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                itemBuilder: (context, i) {
                  // String time = _newsData[key]?[i]['pubDate']['\$t'];
                  // DateTime timeIST = DateTime.parse(time);
                  // timeIST = timeIST
                  //     .add(Duration(hours: 5))
                  //     .add(Duration(minutes: 30));

                  return HomePageCard(
                    //Variables para el Norte
                    // title: _newsData[key]?[i]['title']['__cdata'],
                    // imageUrl: _newsData[key]?[i]['enclosure']['__cdata'],
                    // content: _newsData[key]?[i]['link']['\$t'],
                    // subtitle: _newsData[key]?[i]['description']['__cdata'],
                    // time: "",

                    //Variables para Expansion
                    title: _newsData[key]?[i]['title']['\$t'],
                    subtitle: _newsData[key]?[i]['description']['\$t'],
                    imageUrl: _newsData[key]?[i]['enclosure']['url'],
                    time:"",
                    // time: timeIST.day.toString() +
                    //     " " +
                    //     getMonthNumberInWords(month: timeIST.month) +
                    //     " " +
                    //     timeIST.toString().split(" ")[1].substring(0, 5),
                    content: _newsData[key]?[i]['content\$encoded']['\$t'],
                  );
                },
                // itemCount: _newsData[key]?.length ?? 0,
                itemCount: 4,
              );
            })));
  }
}
