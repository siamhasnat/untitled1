import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ShoppingCart(),
    );
  }
}

class Product {
  final String name;
  final double price;
  final String size;
  final String color;
  final String imageUrl;

  Product({
    required this.name,
    required this.price,
    required this.size,
    required this.color,
    required this.imageUrl,
  });
}

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  List<Product> products = [
    Product(
      name: 'Shirt',
      price: 20.0,
      size: 'M',
      color: 'Blue',
      imageUrl: 'https://5.imimg.com/data5/ANDROID/Default/2021/3/XQ/EU/WP/125734525/ms-0fc4f-512-20602483-jpg-500x500.jpg',
    ),
    Product(
      name: 'Pant',
      price: 30.0,
      size: 'L',
      color: 'Black',
      imageUrl: 'https://static-01.daraz.com.bd/p/b955d7e2b32b67f8de3dbafe3e6ed1ae.jpg',
    ),
    Product(
      name: 'Shoe',
      price: 50.0,
      size: '10',
      color: 'White',
      imageUrl: 'https://static.vecteezy.com/system/resources/previews/026/512/235/non_2x/futuristic-fashion-original-sneakers-future-design-of-stylish-sports-shoes-with-neon-glow-futuristic-urban-aesthetics-sportswear-style-and-fashion-tomorrow-footwear-ai-generative-free-photo.jpg',
    ),
  ];

  List<int> itemQuantities = [1, 1, 1];

  void incrementItem(int index) {
    setState(() {
      itemQuantities[index]++;
    });
  }

  void decrementItem(int index) {
    if (itemQuantities[index] > 1) {
      setState(() {
        itemQuantities[index]--;
      });
    }
  }

  double calculateTotal() {
    double total = 0.0;
    for (int i = 0; i < products.length; i++) {
      total += itemQuantities[i] * products[i].price;
    }
    return total;
  }

  void checkout() {
    final snackBar = SnackBar(
      content: Text('Congratulations! Order placed successfully.'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showMoreInfo(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('More Information'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Product: ${products[index].name}'),
              Text('Price: \$${products[index].price.toStringAsFixed(2)}'),
              Text('Size: ${products[index].size}'),
              Text('Color: ${products[index].color}'),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My Bag',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    // Implement your search functionality here
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            for (int i = 0; i < products.length; i++)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.network(
                            products[i].imageUrl,
                            height: 80.0,
                            width: 80.0,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Product: ${products[i].name}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text('Size: ${products[i].size}'),
                              Text('Color: ${products[i].color}'),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.remove),
                                    onPressed: () => decrementItem(i),
                                  ),
                                  Text('Items: ${itemQuantities[i]}'),
                                  IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () => incrementItem(i),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: Icon(Icons.more_vert),
                            onPressed: () {
                              showMoreInfo(i);
                            },
                          ),
                          SizedBox(height: 10),
                          Text(
                            '\$${(products[i].price * itemQuantities[i]).toStringAsFixed(2)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            SizedBox(height: 20),
            // Move Total to the left side and the total amount to the right side in the same row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  '\$${calculateTotal().toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Spacer(),
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: checkout,
                    child: Text('CHECK OUT'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
