import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:new_app/extension/media_query_extension.dart';
import 'package:new_app/model/categories_model.dart';
import 'package:new_app/utils/utils.dart';
import 'package:new_app/view_model.dart/view_model.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<String> categorList = [
    'General',
    'Entertainment',
    'Health',
    'Sports',
    'Business',
    'Technology'
  ];

  String? categoriesName = 'General';
  final format = DateFormat('MMMM dd, yyyy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      const Padding(padding: EdgeInsets.only(right: 12)),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        categoriesName = categorList[index].toString();
                        setState(() {});
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: categoriesName == categorList[index]
                                ? Colors.blue
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Center(
                              child: Text(
                            categorList[index].toString(),
                            style: GoogleFonts.poppins(
                                color: categoriesName == categorList[index]
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 13),
                          )),
                        ),
                      ),
                    );
                  },
                  itemCount: categorList.length,
                ),
              ),
              SizedBox(
                height: context.screenHeight * .01,
              ),
              Expanded(
                  child: FutureBuilder<CategoriesModel>(
                future: context
                    .read<NewsViewModel>()
                    .getCategories(categoriesName!),
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
              ))
            ],
          ),
        ),
      ),
    );
  }
}
