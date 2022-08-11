import 'package:flutter/material.dart';
import 'package:furniture_shop/shop_products.dart';
import "package:intl/intl.dart";

var f = NumberFormat.currency(
  locale: 'id',
  symbol: 'Rp ',
  decimalDigits: 0,
);

class DetailScreen extends StatelessWidget {
  final ShopProducts product;

  // ignore: use_key_in_widget_constructors
  const DetailScreen({required this.product});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Hero(
                  tag: product.name,
                  child: Image.asset(
                    product.imageAsset,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        const Text(
                          'Furniture Shop',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12.0, left: 12.0),
                  child: Text(
                    product.name,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 12.0, right: 12.0),
                  child: FavoriteButton(),
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                f.format(int.parse(product.price)),
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontSize: 24.0,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: const <Widget>[
                      Icon(Icons.delivery_dining_outlined),
                      SizedBox(height: 8.0),
                      Text(
                        'Free Delivery',
                      ),
                    ],
                  ),
                  Column(
                    children: const <Widget>[
                      Icon(Icons.check_box_rounded),
                      SizedBox(height: 8.0),
                      Text(
                        'Garansi',
                      ),
                    ],
                  ),
                  Column(
                    children: const <Widget>[
                      Icon(Icons.palette_outlined),
                      SizedBox(height: 8.0),
                      Text(
                        'Costumizeable',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: OrderCount(product: product),
            ),
            Container(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                product.description,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({Key? key}) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
      ),
      onPressed: () {
        setState(() {
          isFavorite = !isFavorite;
        });
      },
    );
  }
}

class OrderCount extends StatefulWidget {
  final ShopProducts product;

  // ignore: use_key_in_widget_constructors
  const OrderCount({required this.product});

  @override
  _OrderCount createState() => _OrderCount();
}

class _OrderCount extends State<OrderCount> {
  int _counter = 0;

  void _incrementCount() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCount() {
    setState(() {
      if (_counter <= 0) {
        _counter = 0;
      } else {
        _counter--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.deepOrange,
              child: IconButton(
                icon: const Icon(
                  Icons.exposure_minus_1,
                  color: Colors.white,
                ),
                onPressed: () {
                  _decrementCount();
                },
              ),
            ),
            Text(
              '$_counter Unit',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            CircleAvatar(
              backgroundColor: Colors.deepOrange,
              child: IconButton(
                icon: const Icon(
                  Icons.exposure_plus_1,
                  color: Colors.white,
                ),
                onPressed: () {
                  _incrementCount();
                },
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            'Total Harga: ${f.format(_counter * int.parse(widget.product.price))}',
            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
