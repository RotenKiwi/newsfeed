import 'package:flutter/material.dart';
import '../../../constants/date_time_convertoer.dart';
import '../../../constants/text_styles.dart';
import '../../models/news_model.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({
    super.key,
    required this.news,
  });

  final Articles? news;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      margin: const EdgeInsets.only(bottom: 15.0),
      padding: const EdgeInsets.symmetric(
          horizontal: 10.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  news?.author ?? "-News Source-",
                  style: boldText(Colors.black),
                ),
                Expanded(
                  child: Text(
                    news?.title ?? "-News Body-",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: regularText,
                  ),
                ),
                Text(
                  (news?.publishedAt != null)
                      ? formatDateTime(news!.publishedAt!)
                      : '-No Time-',
                  style: smallText,
                ),
              ],
            ),
          ),
          const SizedBox(width: 20.0),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: (news?.urlToImage != null)
                ? Image.network(
              news?.urlToImage ?? "",
              height: 120.0,
              width: 120.0,
              fit: BoxFit.cover,
            )
                : Image.asset('images/breaking_news.png'),
          ),
        ],
      ),
    );
  }
}
