import 'package:flutter/material.dart';

void main() {
  runApp(const ShoppingApp());
}

class ShoppingApp extends StatelessWidget {
  const ShoppingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const ShoppingScreen(),
    );
  }
}

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({super.key});

  @override
  _ShoppingScreenState createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  int totalPrice = 0;
  List<Item> items = [
    Item(
      name: 'Formal Suit',
      price: 10000,
      quantity: 0,
      imageUrl:
      'https://th.bing.com/th/id/OIP.w2iHTOWVhEDSL8gq89ZVQQHaHZ?rs=1&pid=ImgDetMain', // Replace with your image URL
    ),
    Item(
      name: 'Formal Pant',
      price: 1000,
      quantity: 0,
      imageUrl:
      'https://th.bing.com/th/id/R.d522896703d50151056e2399ac1a7651?rik=Xck0BsTQsUTINg&riu=http%3a%2f%2fimage.made-in-china.com%2f2f0j00sKNtEdeyMgbV%2fmens-formal-trousers-pant.jpg&ehk=RcsTyRPZygoaHAKdrztnCzcn2cjWCBIdmmIhIcMCea8%3d&risl=&pid=ImgRaw&r=0', // Replace with your image URL
    ),
    Item(
      name: 'Formal Dress',
      price: 4500,
      quantity: 0,
      imageUrl:
      'https://th.bing.com/th/id/OIP.oMpkl0n6zGmmxutenBEV0AHaKw?w=206&h=300&c=7&r=0&o=5&dpr=1.3&pid=1.7', // Replace with your image URL
    ),
  ];

  void updateTotalPrice() {
    int total = 0;
    for (var item in items) {
      total += item.price * item.quantity;
    }
    setState(() {
      totalPrice = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'My Bag',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                  leading: SizedBox(
                    width: 80,
                    height: 80,
                    child: Image.network(
                      items[index].imageUrl,
                      fit: BoxFit.cover,
                      width: 80, // Specify the desired width
                      height: 80, // Specify the desired height
                    ),
                  ),
                  title: Text(items[index].name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Color: white, Size: M'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  setState(() {
                                    if (items[index].quantity > 0) {
                                      items[index].quantity--;
                                      updateTotalPrice();
                                    }
                                  });
                                },
                              ),
                              Text(items[index].quantity.toString()),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  setState(() {
                                    items[index].quantity++;
                                    updateTotalPrice();

                                    if (items[index].quantity == 5) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('Congratulations',
                                              textAlign: TextAlign.center, // Aligns the text center
                                              style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,),),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  'You have added 5 ${items[index].name} to your bag!',
                                              style: const TextStyle(
                                              fontSize: 16.0,),
                                                ),
                                                const SizedBox(height: 16.0),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        style: ButtonStyle(
                                                          backgroundColor:
                                                          MaterialStateProperty.all(
                                                              Colors.red),
                                                        ),
                                                        child: const Padding(
                                                          padding:
                                                          EdgeInsets.all(
                                                              12.0),
                                                          child: Text(
                                                            'OK',
                                                            style: TextStyle(
                                                              fontSize: 16.0,
                                                              fontWeight:
                                                              FontWeight.bold,
                                                              color: Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  });
                                },
                              ),
                            ],
                          ),
                          Text(
                            '\$${items[index].price}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Amount:',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\$$totalPrice',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Congratulations! Your order is placed.'),
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  'Checkout',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Item {
  final String name;
  final int price;
  final String imageUrl;
  int quantity;

  Item({
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });
}
