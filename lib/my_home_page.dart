import 'dart:convert';

import 'package:flutter/material.dart';
// ignore: library_prefixes
import 'package:act9reza0534/app_colors.dart' as AppColors;
import 'package:act9reza0534/my_tabs.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late List popularpizzas;
  late ScrollController _scrollController;
  late TabController _tabController;

  // ignore: non_constant_identifier_names
  ReadData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/pizzas.json")
        .then((s) {
      setState(() {
        popularpizzas = json.decode(s);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    ReadData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: SafeArea(
          child: Scaffold(
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ImageIcon(
                    AssetImage("assets/images/Menu.png"),
                    size: 24,
                    color: Colors.black,
                  ),
                  Row(
                    children: [
                      Icon(Icons.search),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.notifications)
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: const Text(
                    "Pizzería Reza 0534",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            // ignore: sized_box_for_whitespace
            Container(
              height: 180,
              child: Stack(children: [
                Positioned(
                  top: 0,
                  left: -20,
                  right: 0,
                  // ignore: sized_box_for_whitespace
                  child: Container(
                    height: 180,
                    child: PageView.builder(
                        controller: PageController(viewportFraction: 0.8),
                        // ignore: unnecessary_null_comparison
                        itemCount:
                            popularpizzas == null ? 0 : popularpizzas.length,
                        itemBuilder: (_, i) {
                          return Container(
                            height: 180,
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  image: AssetImage(popularpizzas[i]["img"]),
                                  fit: BoxFit.fill),
                            ),
                          );
                        }),
                  ),
                )
              ]),
            ),
            Expanded(
                child: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder: (BuildContext context, bool isScroll) {
                return [
                  SliverAppBar(
                    pinned: true,
                    backgroundColor: AppColors.sliverbackground,
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(50),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 20, left: 10),
                        child: TabBar(
                          indicatorPadding: const EdgeInsets.all(0),
                          indicatorSize: TabBarIndicatorSize.label,
                          labelPadding: const EdgeInsets.only(right: 10),
                          controller: _tabController,
                          isScrollable: true,
                          indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 7,
                                  offset: const Offset(0, 0),
                                )
                              ]),
                          tabs: [
                            AppTabs(
                                color: AppColors.menu1color, text: "Populares"),
                            AppTabs(
                                color: AppColors.menu2color, text: "Nuevas"),
                            AppTabs(color: AppColors.menu3color, text: "Todas"),
                          ],
                        ),
                      ),
                    ),
                  )
                ];
              },
              body: TabBarView(
                controller: _tabController,
                children: [
                  ListView.builder(
                      itemCount:
                          popularpizzas == null ? 0 : popularpizzas.length,
                      itemBuilder: (_, i) {
                        return Container(
                          margin: EdgeInsets.only(
                              left: 20, right: 20, top: 10, bottom: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.tabBarViewColor,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 2,
                                      offset: Offset(0, 0),
                                      color: Colors.grey.withOpacity(0.2))
                                ]),
                            child: Container(
                              padding: EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Container(
                                    width: 90,
                                    height: 120,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: AssetImage(
                                              popularpizzas[i]["img"]),
                                        )),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            size: 24,
                                            color: AppColors.starcolor,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            popularpizzas[i]["rating"],
                                            style: TextStyle(
                                                color: AppColors.menu2color),
                                          )
                                        ],
                                      ),
                                      Text(
                                        popularpizzas[i]["title"],
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: "Avenir",
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        popularpizzas[i]["text"],
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: "Avenir",
                                            color: AppColors.subtitletext),
                                      ),
                                      Container(
                                        width: 60,
                                        height: 15,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            color: AppColors.lovecolor),
                                        child: Text(
                                          "Ordenar",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: "Avenir",
                                              color: Colors.white),
                                        ),
                                        alignment: Alignment.center,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                  const Material(
                    child: ListTile(
                      leading: CircleAvatar(backgroundColor: Color(0xffd46318)),
                      title: Text("Extra"),
                    ),
                  ),
                  const Material(
                    child: ListTile(
                      leading: CircleAvatar(backgroundColor: Color(0xffbe1818)),
                      title: Text("Extra"),
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      )),
    );
  }
}
