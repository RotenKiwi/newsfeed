import 'package:flutter/material.dart';
import 'package:pingolearn_task1/constants/text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/colors.dart';
import '../models/news_model.dart';

class SingleNewsScreen extends StatelessWidget {
  const SingleNewsScreen({super.key, required this.newsArticle});

  final Articles newsArticle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primary,
        title: Text(
          newsArticle.author ?? "News Author",
          style: boldText(Colors.white),
        ),
        leading: const BackButton(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
        child: Column(
          children: [
            newsArticle.urlToImage == null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      "images/breaking_news.png",
                      height: 340.0,
                      width: double.maxFinite,
                      fit: BoxFit.cover,
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      newsArticle.urlToImage ?? "",
                      height: 340.0,
                      width: double.maxFinite,
                      fit: BoxFit.cover,
                    ),
                  ),
            const SizedBox(
              height: 20.0
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      newsArticle.title ?? "News Title",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: boldText(Colors.black),
                    ),
                    const SizedBox(height: 8.0,),
                    (newsArticle.description!=null)?Text(
                      newsArticle.description! ,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 6,
                      style: regularText,
                    ):const SizedBox(),
                    InkWell(
                      onTap: () async {
                        if (!await launchUrl(
                            Uri.parse(newsArticle.url ?? ""))) {
                          throw Exception('Could not launch ');
                        }
                      },
                      child: const Text(
                        "Click to read more",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                            color: primary),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0
                    ),
                    Row(
                      children: [
                        Text(
                          "Published On: ${newsArticle.publishedAt.toString().split("T")[0]}",
                          overflow: TextOverflow.ellipsis,
                          style: regularText,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
