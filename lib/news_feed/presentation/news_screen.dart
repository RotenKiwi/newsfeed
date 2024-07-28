import 'package:flutter/material.dart';
import 'package:pingolearn_task1/constants/text_styles.dart';
import 'package:pingolearn_task1/news_feed/presentation/single_news_screen.dart';
import 'package:provider/provider.dart';

import '../../authentication/presentation/login_screen.dart';
import '../../authentication/providers/provider_auth.dart';
import '../../constants/colors.dart';
import '../provider/home_provider.dart';
import 'components/news_card.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
    final provider = Provider.of<HomeProvider>(context, listen: false);
    provider.getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: primary,
        title: Text("MyNews", style: boldText(Colors.white)),
        actions: [
          const Icon(Icons.location_on_outlined, color: Colors.white),
          const SizedBox(width: 4.0),
          Text(
            Provider.of<HomeProvider>(context, listen: true)
                .remoteConfig
                .getString("country")
                .toString()
                .toUpperCase(),
            style: boldText(Colors.white),
          ),
          const SizedBox(width: 10.0),
          IconButton(
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            icon: const Icon(Icons.logout, color: Colors.white),
          ),
          const SizedBox(width: 10.0)
        ],
      ),
      body: Consumer<HomeProvider>(
        builder: (context, homeProvider, child) {
          return homeProvider.newsModel != null
              ? const HomePage()
              : const Center(child: CircularProgressIndicator.adaptive());
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Top Headlines", style: bigText),
          const SizedBox(height: 21.0),
          Consumer<HomeProvider>(builder: (context, homeProvider, child) {
            return Expanded(
              child: ListView.builder(
                  itemCount: homeProvider.newsModel?.posts?.length ?? 0,
                  itemBuilder: (context, index) {
                    var news = homeProvider.newsModel?.posts?[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SingleNewsScreen(newsArticle: news!),
                          ),
                        );
                      },
                      child: NewsCard(news: news),
                    );
                  }),
            );
          }),
        ],
      ),
    );
  }
}
