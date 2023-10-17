import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:new_app/extension/media_query_extension.dart';
import 'package:new_app/model/bbc_model.dart';
import 'package:new_app/model/categories_model.dart';
import 'package:new_app/utils/utils.dart';
import 'package:new_app/view/category_screen.dart';
import 'package:new_app/view/news_details_screen.dart';
import 'package:new_app/view_model.dart/view_model.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
enum newsFilterList { bbcnews, arynews, cnn }

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = 'bbc-news';

  newsFilterList? selectedMenu;

  @override
  Widget build(BuildContext context) {
    final format = DateFormat('MMMM dd, yyyy');
    return Scaffold(
      appBar: AppBar(
          actions: [
            PopupMenuButton<newsFilterList>(
              padding: EdgeInsets.zero,
              color: Colors.black,
              initialValue: selectedMenu,
              icon: const Icon(Icons.more_vert, color: Colors.black),
              onSelected: (newsFilterList item) {
                if (newsFilterList.bbcnews.name == item.name) {
                  name = 'bbc-news';
                }
                if (newsFilterList.arynews.name == item.name) {
                  name = 'al-jazeera-english';
                }
                if (newsFilterList.cnn.name == item.name) {
                  name = 'cnn';
                }
                setState(() {
                  selectedMenu = item;
                });
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<newsFilterList>>[
                PopupMenuItem(
                  value: newsFilterList.bbcnews,
                  child: Text(
                    "BBC News",
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                ),
                PopupMenuItem(
                  value: newsFilterList.arynews,
                  child: Text(
                    "AL-JAZEERA News",
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                ),
                PopupMenuItem(
                  value: newsFilterList.cnn,
                  child: Text(
                    "CNN News",
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                )
              ],
            )
          ],
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CategoryScreen()));
            },
            icon: Image.asset(
              'assets/images/category_icon.png',
              height: 30,
              width: 30,
            ),
          ),
          title: Text(
            "News",
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          )),
      body: ListView(
        children: [
          SizedBox(
            height: context.screenHeight * .55,
            child: FutureBuilder<BBCModel>(
                future: context.read<NewsViewModel>().fetchModel(name),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: Utils.spinkit());
                  } else if (snapshot.data!.articles!.isEmpty ||
                      snapshot.data == null) {
                    return const Center(
                      child: Text("No Data"),
                    );
                  } else {
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.articles!.length,
                        itemBuilder: (context, index) {
                          DateTime dateTime = DateTime.parse(snapshot
                              .data!.articles![index].publishedAt
                              .toString());
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NewsDetailsScreen(
                                    imageUrl: snapshot
                                        .data!.articles![index].urlToImage
                                        .toString(),
                                    title: snapshot.data!.articles![index].title
                                        .toString(),
                                    source: snapshot
                                        .data!.articles![index].source!.name
                                        .toString(),
                                    time: snapshot
                                        .data!.articles![index].publishedAt
                                        .toString(),
                                    description: snapshot
                                        .data!.articles![index].description
                                        .toString(),
                                  ),
                                ),
                              );
                            },
                            child: SizedBox(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: context.screenHeight * .02),
                                    height: context.screenHeight * .6,
                                    width: context.screenWidth * .9,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.fill,
                                        imageUrl: snapshot
                                            .data!.articles![index].urlToImage
                                            .toString(),
                                        placeholder: (context, url) =>
                                            Container(
                                          child: Utils.showShimmer(
                                            context,
                                            context.screenHeight * .6,
                                            context.screenWidth * .9,
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(
                                          Icons.error_outline_outlined,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 20,
                                    child: SizedBox(
                                      child: Card(
                                        color: Colors.grey.shade200,
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Container(
                                          height: context.screenHeight * .22,
                                          padding: const EdgeInsets.all(15),
                                          alignment: Alignment.bottomCenter,
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width:
                                                      context.screenWidth * 0.7,
                                                  child: Text(
                                                    snapshot.data!
                                                        .articles![index].title
                                                        .toString(),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                                const Spacer(),
                                                SizedBox(
                                                  width:
                                                      context.screenWidth * 0.7,
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            snapshot
                                                                .data!
                                                                .articles![
                                                                    index]
                                                                .source!
                                                                .name
                                                                .toString(),
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: GoogleFonts
                                                                .poppins(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            format.format(
                                                                dateTime),
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: GoogleFonts
                                                                .poppins(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ),
                                                      ]),
                                                )
                                              ]),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  }
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: FutureBuilder<CategoriesModel>(
              future: context.read<NewsViewModel>().getCategories('General'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: Utils.spinkit());
                } else if (snapshot.data!.articles!.isEmpty ||
                    snapshot.data == null) {
                  return const Center(
                    child: Text("No Data"),
                  );
                } else {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      DateTime dateTime = DateTime.parse(snapshot
                          .data!.articles![index].publishedAt
                          .toString());
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: CachedNetworkImage(
                                width: context.screenWidth * .3,
                                height: context.screenHeight * .18,
                                fit: BoxFit.cover,
                                imageUrl: snapshot
                                    .data!.articles![index].urlToImage
                                    .toString(),
                                placeholder: (context, url) => Container(
                                  child: Utils.showShimmer(
                                    context,
                                    context.screenHeight * .18,
                                    context.screenWidth * .3,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(
                                  Icons.error_outline_outlined,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: context.screenHeight * .18,
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Column(
                                  children: [
                                    Text(
                                      snapshot.data!.articles![index].title
                                          .toString(),
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        color: Colors.black54,
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const Spacer(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            snapshot.data!.articles![index]
                                                .source!.name
                                                .toString(),
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black54,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            format.format(dateTime),
                                            textScaleFactor:
                                                context.screenWidth * .002,
                                            style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    itemCount: snapshot.data!.articles!.length,
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
