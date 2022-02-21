import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/Category.dart';
import 'package:news_app/models/News.dart';
import 'package:news_app/provider/NewsProvider.dart';
import 'package:news_app/widgets/BlogTile.dart';
import 'package:news_app/widgets/CategoryTile.dart';
import 'package:provider/provider.dart';

class HomeApp extends StatefulWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  _HomeAppState createState() => _HomeAppState();
}

String blogImage =
    "https://www.gomodus.com/hubfs/Blog%20Images/Tech%20Changes%20Business.jpg";
List<Category> getAllList() {
  List<Category> list = [];

  list.add(Category(
      name: "Technology",
      url:
          "https://www.gomodus.com/hubfs/Blog%20Images/Tech%20Changes%20Business.jpg"));
  list.add(Category(
      name: "Stores",
      url:
          "https://www.gomodus.com/hubfs/Blog%20Images/Tech%20Changes%20Business.jpg"));
  list.add(Category(
      name: "Development",
      url:
          "https://www.gomodus.com/hubfs/Blog%20Images/Tech%20Changes%20Business.jpg"));
  list.add(Category(
      name: "Business",
      url:
          "https://www.gomodus.com/hubfs/Blog%20Images/Tech%20Changes%20Business.jpg"));

  return list;
}

List<Category> getCategories() {
  List<Category> myCategories = [];
  Category categorieModel;

  //1
  categorieModel = Category(
      name: "Business",
      url:
          "https://images.unsplash.com/photo-1507679799987-c73779587ccf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1502&q=80");
  myCategories.add(categorieModel);

  //2
  categorieModel = Category(
      name: "Entertainment",
      url:
          "https://images.unsplash.com/photo-1522869635100-9f4c5e86aa37?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80");
  myCategories.add(categorieModel);

  //3
  categorieModel = Category(
      name: "General",
      url:
          "https://images.unsplash.com/photo-1495020689067-958852a7765e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60");
  myCategories.add(categorieModel);

  //4
  categorieModel = Category(
      name: "Health",
      url:
          "https://images.unsplash.com/photo-1494390248081-4e521a5940db?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1595&q=80");
  myCategories.add(categorieModel);

  //5
  categorieModel = Category(
      name: "Science",
      url:
          "https://images.unsplash.com/photo-1554475901-4538ddfbccc2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1504&q=80");
  myCategories.add(categorieModel);

  //6
  categorieModel = Category(
      name: "Sports",
      url:
          "https://images.unsplash.com/photo-1495563923587-bdc4282494d0?ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80");
  myCategories.add(categorieModel);

  //7
  categorieModel = Category(
      name: "Technology",
      url:
          "https://images.unsplash.com/photo-1519389950473-47ba0277781c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80");
  myCategories.add(categorieModel);
  return myCategories;
}

var newList = [];

class _HomeAppState extends State<HomeApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "Material",
              style: TextStyle(color: Colors.black),
            ),
            Text(
              "News",
              style: TextStyle(color: Colors.blue),
            )
          ],
        ),
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : Container(
              child: Column(
                children: [
                  Container(
                    height: 70,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: getCategories().length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                getAllNews(
                                    getCategories()[index].name.toString());
                              });
                            },
                            child: CategoryTile(
                              name: getCategories()[index].name,
                              url: getCategories()[index].url,
                            ),
                          );
                        }),
                  ),
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                          itemCount: newList.length,
                          itemBuilder: (context, position) {
                            News news = newList[position];
                            return BlogTile(news.title, news.description,
                                news.image, news.postUrl);
                          }),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  bool _loading = true;
  void getAllNews(String topicName) async {
    _loading = true;
    await Provider.of<NewsProvider>(context, listen: false).getNews(topicName);
    print("Function Called Finished");
    newList = Provider.of<NewsProvider>(context, listen: false).newsList;
    print("Assign Complete & Size " + newList.length.toString());

    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    print("Init Calling");
    print("Loading ");
    getAllNews("Technology");
    super.initState();
  }
}
