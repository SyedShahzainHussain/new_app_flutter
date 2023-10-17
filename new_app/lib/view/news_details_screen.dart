import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:new_app/extension/media_query_extension.dart';
import 'package:new_app/utils/utils.dart';

class NewsDetailsScreen extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String source;
  final String time;
  final String description;
  const NewsDetailsScreen({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.source,
    required this.time,
    required this.description,
  });

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  final format = DateFormat("MMM dd, yyyy");
  @override
  Widget build(BuildContext context) {
    final date = DateTime.parse(widget.time.toString());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          SizedBox(
              height: context.screenHeight * .45,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(40),
                ),
                child: CachedNetworkImage(
                  imageUrl: widget.imageUrl,
                  fit: BoxFit.fill,
                  placeholder: (context, url) => Container(
                    child: Utils.spinkit(),
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error_outline_outlined,
                    color: Colors.red,
                  ),
                ),
              )),
          Container(
              height: context.screenHeight * .55,
              margin: EdgeInsets.only(top: context.screenHeight * .4),
              padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: ClipRRect(
                child: ListView(children: [
                  Text(
                    widget.title,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      color: Colors.black87,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: context.screenHeight * .02),
                  Row(children: [
                    Expanded(
                      child: Text(
                        widget.source,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      format.format(date),
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ]),
                  SizedBox(height: context.screenHeight * .03),
                  Text(
                    widget.description,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: context.screenHeight * .03),
                ]),
              )),
        ],
      ),
    );
  }
}
