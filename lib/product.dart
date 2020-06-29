import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/producModel.dart';
import 'package:flutterapp/productCard.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage>
    with SingleTickerProviderStateMixin {
  // initialize a  tabController for moving the tabs
  TabController tabController;
  // initialize a  pageController for moving the page
  PageController _pageController = PageController(viewportFraction: 0.9);

  // initialize a List of my products
  List<ProductModel> products = [];
  List<ProductModel> americanoProducts = [];
  int currentIndexOfTab = 0;
  int currentIndex = 0;
  // tracking the state of my tab & pageController  & my product with the currentIndex

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
    // added products into the list of products from my product Model
    products
        .add(ProductModel('Cappuccino', 'Lattesso', 'images/coffee.png', 350));
    products
        .add(ProductModel('Cappuccino', 'Fareto', 'images/coffee.png', 310));
    products
        .add(ProductModel('Cappuccino', 'Lattoroe', 'images/coffee.png', 900));

    americanoProducts.add(
        ProductModel('Americano', 'Black Coffee', 'images/coffee.png', 600));
    americanoProducts
        .add(ProductModel('Americano', 'Capprioco', 'images/coffee.png', 450));
    americanoProducts
        .add(ProductModel('Americano', 'Mooffee', 'images/coffee.png', 120));
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
              Column(
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
                  Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: Text(
                      'Coffee',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // indicator
                  Row(
                    children: [
                      indicator(
                        position: 1,
                        currentIndex: currentIndex,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      indicator(
                        position: 2,
                        currentIndex: currentIndex,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      indicator(
                        position: 3,
                        currentIndex: currentIndex,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              TabBarView(
                controller: tabController,
                children: [
                  PageView.builder(
                    onPageChanged: (index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return Products(
                        productModel: products[index],
                      );
                    },
                    controller: _pageController,
                  ),
                  PageView.builder(
                    onPageChanged: (index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return Products(
                        productModel: americanoProducts[index],
                      );
                    },
                    controller: _pageController,
                  ),
                ],
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
                            moveCategory();
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 24,
                    ),
                    TabBar(
                      controller: tabController,
                      labelColor: Colors.brown,
                      unselectedLabelColor: Colors.grey,
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'Gilroy'),
                      unselectedLabelStyle:
                          TextStyle(fontWeight: FontWeight.w300),
                      isScrollable: true,
                      indicatorColor: Colors.transparent,
                      tabs: [
                        Text('Cappucino'),
                        Text('Americano'),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget indicator({int position, currentIndex}) {
    return Container(
      width: position == currentIndex + 1 ? 20 : 6,
      height: 6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: position == currentIndex + 1
            ? Colors.brown
            : Colors.grey.withOpacity(0.5),
      ),
    );
  }

  void moveCategory() {
    if (currentIndex == 1) {
      tabController.previousIndex;
    } else {
      tabController.animateTo(currentIndexOfTab + 1,
          duration: duration, curve: curve);
    }
  }

  static const duration = Duration(milliseconds: 600);
  static const curve = Curves.easeIn;
}
