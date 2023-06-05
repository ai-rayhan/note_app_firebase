
import 'package:flutter/material.dart';

import '../provider/news.dart';
import '../widgets/news_details_screen.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  NewsScreenState createState() => NewsScreenState();
}

class NewsScreenState extends State<NewsScreen> {
  List<Post> _posts = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  Future<void> _fetchPosts() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final posts = await Api.fetchPosts();
      setState(() {
        _posts = posts;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      throw Exception('Failed to fetch posts: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
                itemCount: _posts.length,
                itemBuilder: (context, index) {
                  final post = _posts[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PostDetailsScreen(post: post),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey.shade300,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post.title,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            post.body,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
          ),
    );
  }
}