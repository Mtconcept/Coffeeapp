import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/producModel.dart';
import 'main.dart';
import 'producModel.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage>
    with SingleTickerProviderStateMixin {
  PageController _pageController = PageController(viewportFraction: 0.9);

  ProductModel _products;
  Category categories;
  int currentIndexOfCategories = 0;
  int currentIndex = 0;
  int indexx = 0;
  ProductModel coffeeCategory;
  Content _content;
  Category _category;

  Future<String> coffeeJSonData() async {
    try {
      return await rootBundle.loadString('assets/coffee.json');
    } catch (e) {
      print(e);
    }
    return coffeeJSonData();
  }

  Future loadData() async {
    String jsonString = await coffeeJSonData();
    final jsonResponse = json.decode(jsonString);
//    print(jsonResponse);
    coffeeCategory = ProductModel.fromJson(jsonResponse);
    print(coffeeCategory.categories);
    productContent = coffeeCategory.categories[currentIndex].contents;
    _category = coffeeCategory.categories[currentIndexOfCategories];
    return coffeeCategory;
  }

  List<Content> productContent = List<Content>();

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffede7e7),
      body: Container(
        width: width,
        child: Padding(
          padding: EdgeInsets.only(top: 38.0, left: 24),
          child: Stack(
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    selectCoffeeText(),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      height: 6,
                      width: double.infinity,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: productContent.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: 2),
                              child: indicator(
                                currentIndex: indexx,
                                position: index,
                              ),
                            );
                          }),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      height: 450,
                      child: PageView.builder(
                        onPageChanged: (index) {
                          setState(() {
                            indexx = index;
                          });
                        },
                        itemCount: productContent.length,
                        controller: _pageController,
                        itemBuilder: (context, index) {
//                          print(productContent);
                          return productCard(context, productContent, index);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                  bottom: 50,
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: Center(
                          child: IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () {
                              if (currentIndex == 0) {
                                currentIndexOfCategories++;
                              } else if (currentIndexOfCategories <=
                                  coffeeCategory.categories.length) {
                                currentIndexOfCategories--;
                              }
                            },
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 300,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: coffeeCategory == null
                                ? 0
                                : coffeeCategory.categories.length,
                            itemBuilder: (context, index) =>
                                _categoryItem(index)),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget selectCoffeeText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              fontFamily: 'Gilroy',
              color: Colors.black),
        ),
        Text(
          'Coffee',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _categoryItem(index) {
    return InkWell(
      onTap: () {
        setState(() {
          currentIndexOfCategories = index;
          _category = coffeeCategory.categories[index];
          productContent = coffeeCategory.categories[index].contents;
          _pageController.jumpToPage(0);
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Text(
          coffeeCategory.categories[index].name,
          style: TextStyle(
              fontWeight: currentIndexOfCategories == index
                  ? FontWeight.bold
                  : FontWeight.normal,
              fontSize: currentIndexOfCategories == index ? 22 : 18,
              color: currentIndexOfCategories == index
                  ? Colors.brown
                  : Colors.grey),
        ),
      ),
    );
  }

  Widget indicator({int position, currentIndex}) {
    return Container(
      width: position == currentIndex ? 20 : 6,
      height: 6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: position == currentIndex
            ? Colors.brown
            : Colors.grey.withOpacity(0.5),
      ),
    );
  }

  Widget productCard(context, List<Content> contentList, index) {
    Content content = contentList[index];
    print(_category.name);
    String _currency = "\$";
    return content != null
        ? Align(
            alignment: Alignment.centerLeft,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed('/details', arguments: content);
                  },
                  child: Container(
                      clipBehavior: Clip.antiAlias,
                      width: 280,
                      height: 400,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(36),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: -32,
                            right: -55,
                            child: Image.asset(
                              content.imgPath,
                              width: 300,
                              filterQuality: FilterQuality.high,
                              colorBlendMode: BlendMode.saturation,
                            ),
                          ),
                          Positioned(
                              bottom: 80,
                              left: 16,
                              child: Text(
                                _category.name != null
                                    ? _category.name
                                    : 'No data',
                                style: TextStyle(
                                    color: Colors.orangeAccent, fontSize: 16),
                              )),
                          Positioned(
                            bottom: 30,
                            left: 16,
                            child: Text(
                              content.title != null ? content.title : 'No data',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 40,
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )),
                ),
                Positioned(
                  bottom: -8,
                  right: -5,
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    height: 36,
                    width: 70,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(50)),
                    child: Center(
                        child: Text(
                      'N' + content.price.toString() != null
                          ? content.price.toString()
                          : 'No data',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    )),
                  ),
                ),
              ],
            ),
          )
        : Container();
  }
}
