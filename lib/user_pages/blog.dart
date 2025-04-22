import 'package:Eye_Health/models/blog.dart';
import 'package:Eye_Health/services/blog.dart';
import 'package:Eye_Health/user_pages/article.dart';
import 'package:Eye_Health/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/header.dart';

class BlogPage extends StatefulWidget {
  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  late Future<List<Article>> _articlesFuture;
  List<Article> _allArticles = [];
  List<Article> _filteredArticles = [];
  int displayedCount = 10; // Initially display 10 items
  bool isLoading = false;

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _articlesFuture = BlogService().fetchArticles();
    _fetchArticles();
  }

  // Function to fetch all articles and store them
  Future<void> _fetchArticles() async {
    setState(() {
      isLoading = true;
    });
    List<Article> articles = await BlogService().fetchArticles();
    setState(() {
      _allArticles = articles;
      _filteredArticles = articles; // Initially show all articles
      isLoading = false;
    });
  }

  // Function to filter articles based on search query
  void _filterArticles(String query) {
    setState(() {
      _filteredArticles = _allArticles
          .where((article) =>
              article.judul != null &&
              article.judul!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  // Function to handle search input changes
  void _onSearchChanged(String query) {
    _filterArticles(query);
  }

  // Function to refresh articles
  Future<void> _refreshArticles() async {
    await _fetchArticles(); // Refresh the articles by fetching fresh data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      endDrawer: SideMenu(),
      body: Column(
        children: [
          Center(
            child: Text(
              "Blog",
              style: TextStyle(
                color: Color.fromRGBO(51, 145, 255, 1),
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 30),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _searchController,
              autocorrect: false,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              onChanged:
                  _onSearchChanged, // Pass the query directly to _onSearchChanged
              decoration: InputDecoration(
                hintText: "Cari...",
                suffixIcon: IconButton(
                  icon: Icon(Icons.search_rounded),
                  onPressed:
                      () {}, // You could handle the button press here if needed
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : _filteredArticles.isEmpty
                    ? Center(child: Text("No articles found"))
                    : GridView.builder(
                        padding: EdgeInsets.all(10),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: _filteredArticles.length,
                        itemBuilder: (context, index) {
                          final article = _filteredArticles[index];
                          return GestureDetector(
                            onTap: () {
                              // Navigate to Article Detail Page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ArticleDetailPage(
                                    article: article,
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Display Image
                                  if (article.gambar != null)
                                    ClipRRect(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(15)),
                                      child: Image.network(
                                        article.gambar!,
                                        height: 120,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                            height: 120,
                                            color: Colors.grey[300],
                                            child: Icon(Icons.broken_image,
                                                size: 50, color: Colors.grey),
                                          );
                                        },
                                      ),
                                    ),
                                  SizedBox(height: 8),
                                  // Display Title
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                      article.judul ?? "No Title",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _refreshArticles, // Refresh when tapped
        child: Icon(Icons.refresh),
      ),
      bottomNavigationBar: BottomNavigation(
        selectedIndex: 0,
        pageIndex: 10,
      ),
    );
  }
}
