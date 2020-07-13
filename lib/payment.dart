import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constant.dart';
import 'producModel.dart';

class Payment extends StatefulWidget {
  final Content content;

  const Payment({Key key, this.content}) : super(key: key);
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  bool isSelected = false;
  int selected = 1;
  TextEditingController _cardNumbercontroller;
  TextEditingController _cardHoldercontroller;
  TextEditingController _cvvcontroller;
  TextEditingController _datecontroller;

  @override
  void initState() {
    super.initState();
    print(widget.content.price);
    _cardHoldercontroller = TextEditingController();
    _cardNumbercontroller = TextEditingController();
    _cvvcontroller = TextEditingController();
    _datecontroller = TextEditingController();
  }

  @override
  void dispose() {
    _cardNumbercontroller.dispose();
    _cardHoldercontroller.dispose();
    _cvvcontroller.dispose();
    _datecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE7E8ED),
      appBar: AppBar(
        backgroundColor: Color(0xffE7E8ED),
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black87,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text('Payment data', style: smallText),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total price',
                  style: smallText,
                ),
                Text(
                  widget.content.price.toString(),
                  style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: primaryColor),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Payment Method',
                  style: smallText,
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  height: 60,
                  width: double.infinity,
                  child: ListView.builder(
                      itemCount: 3,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selected = index;
                            });
                          },
                          child: payType(
                              index,
                              index == 0
                                  ? "Paypal"
                                  : index == 1 ? "Credit" : "Wallet"),
                        );
                      }),
                ),
                SizedBox(
                  height:36,
                ),
                Text(
                  'Card number',
                  style: smallText,
                ),
                textFields(
                    _cardNumbercontroller,
                    TextInputType.number,
                    '   My Card Number',
                    true,
                    Image.asset(
                      'images/mastercard.png',
                      width: 30,
                    ),
                    15),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Card holder',
                  style: smallText,
                ),
                textFields(_cardHoldercontroller, TextInputType.name,'Full Name', true,
                    null, null),
                SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CVV',
                          style: smallText,
                        ),
                        textFields(_cvvcontroller,TextInputType.number, 'CVV', true, null, 3),
                      ],
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Date',
                          style: smallText,
                        ),
                        textFields(_datecontroller,TextInputType.datetime, 'MM/YY', false, null, null),
                      ],
                    ))
                  ],
                ),
                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Save card data for future payment',
                      style: smallText,
                    ),
                    Switch(
                        value: isSelected,
                        activeColor: primaryColor,
                        inactiveTrackColor: Colors.grey,
                        onChanged: (value) {
                          setState(() {
                            isSelected = value;
                          });
                        }),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 54,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Text(
                      'Proceed to confirm',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget payType(int currentIndex, String name) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: selected == currentIndex
              ? primaryColor
              : primaryColor.withOpacity(0.5),
          boxShadow: [
            selected == currentIndex
                ? BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: Offset(0, 2), // changes position of shadow
                  )
                : BoxShadow(
                    color: Colors.transparent,
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
          ]),
      child: Row(
        children: [
          Text(
            name,
            style: TextStyle(
                fontSize: 18,
                color: selected == currentIndex
                    ? Colors.white
                    : Colors.white.withOpacity(0.4)),
          ),
          SizedBox(
            width: 16,
          ),
          Icon(
            Icons.check_circle_outline,
            size: 30,
            color: selected == currentIndex
                ? Colors.white
                : Colors.white.withOpacity(0.5),
          ),
        ],
      ),
    );
  }

  Widget textFields(
    TextEditingController controller,
    TextInputType keyboard,
    String fieldName,
    bool obscure,
    Widget prefix,
    int maxLine,
  ) {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return 'Field Cannot be null';
        }
        return null;
      },
      keyboardType:keyboard,
      maxLength: maxLine,
      obscureText: obscure,
      controller: controller,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: BorderSide.none),
          counter: Offstage(),
          filled: true,
          hintText: fieldName,
          hintStyle: TextStyle(fontSize: 16, color: Colors.grey[600]),
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 8),
          prefix: prefix),
    );
  }
}
