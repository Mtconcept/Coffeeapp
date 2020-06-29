import 'package:flutter/material.dart';
import 'package:flutterapp/producModel.dart';

import 'main.dart';

class Products extends StatelessWidget {
  final ProductModel productModel;
  const Products({Key key, this.productModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String _currency = "\$";
    return Align(
      alignment: Alignment.centerLeft,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MyHomePage(
                        productBrand: productModel.productBrand,
                        productName: productModel.productName,
                        price: productModel.price,
                        imgPath: productModel.imgPath,
                      )));
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
                        productModel.imgPath,
                        width: 300,
                        filterQuality: FilterQuality.high,
                        colorBlendMode: BlendMode.saturation,
                      ),
                    ),
                    Positioned(
                        bottom: 80,
                        left: 16,
                        child: Text(
                          productModel.productBrand,
                          style: TextStyle(
                              color: Colors.orangeAccent, fontSize: 16),
                        )),
                    Positioned(
                      bottom: 30,
                      left: 16,
                      child: Text(
                        productModel.productName,
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
              width: 60,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(50)),
              child: Center(
                  child: Text(
                _currency + productModel.price.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
