import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lalaku/mainn.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Sa(),
    ),
  );
}

class Sa extends StatefulWidget {
  const Sa({super.key});

  @override
  State<Sa> createState() => _SaState();
}

class _SaState extends State<Sa> {
  final List<String> imgList = [
    "rasim/w.jpg", // Sushi Roll
    "rasim/u.jpg", // Nigiri
    "rasim/d.jpg", // Sashimi
    "rasim/l.jpg", // Maki
  ];

  final List<String> foodItems = [
    "Original Sushi",
    "Nigiri",
    "Sashimi",
    "Maki",
    "Tempura",
    "Tartare",
    "Sushi Burrito",
    "Inari",
  ];

  final List<double> prices = [
    26.00,
    18.00,
    20.00,
    15.00,
    10.00,
    30.00,
    22.00,
    28.00,
  ];

  TextEditingController _controller = TextEditingController();
  List<String> filteredFoodItems = [];

  @override
  void initState() {
    super.initState();
    filteredFoodItems = foodItems; // Initialize with all food items
  }

  void _filterFoodItems(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredFoodItems = foodItems;
      });
    } else {
      setState(() {
        filteredFoodItems = foodItems
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  void _navigateToDetail(BuildContext context, String foodItem, double price) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FoodDetailPage(foodItem: foodItem, price: price),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Column(
            children: [
              Text(
                "Location",
                style: TextStyle(
                    fontSize: 15,
                    color: const Color.fromARGB(255, 158, 141, 141)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_on, color: Colors.black),
                  SizedBox(width: 4),
                  Text(
                    "Uzbekistan",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ),
        leading: Icon(Icons.panorama),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.notifications_on),
          ),
        ],
      ),
      body: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 200,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 2),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.easeInOut,
            ),
            items: imgList
                .map(
                  (item) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        item,
                        fit: BoxFit.cover,
                        width: 1000,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: _controller,
              onChanged: _filterFoodItems,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                labelText: 'Enter your foods',
                contentPadding: EdgeInsets.symmetric(vertical: 10.0),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Popular Food",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                "View all",
                style: TextStyle(
                  color: Colors.grey,
                ),
              )
            ],
          ),
          SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: filteredFoodItems.length,
              itemBuilder: (context, index) {
                int originalIndex = foodItems.indexOf(filteredFoodItems[index]);
                return GestureDetector(
                  onTap: () => _navigateToDetail(
                      context, filteredFoodItems[index], prices[originalIndex]),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(8.0)),
                          child: Image.asset(
                            "rasim/l.jpg", 
                            width: 150,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          filteredFoodItems[index],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.attach_money, size: 16),
                            Text(prices[originalIndex].toString()),
                          ],
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
    );
  }
}

class FoodDetailPage extends StatelessWidget {
  final String foodItem;
  final double price;

  const FoodDetailPage(
      {super.key, required this.foodItem, required this.price});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(foodItem),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'rasim/l.jpg', // Replace with actual image
                fit: BoxFit.cover,
                height: 200,
              ),
            ),
            SizedBox(height: 16),
            Text(
              foodItem,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber),
                Text('4.8'),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                _buildIconText(Icons.label_important_outline_sharp, 'Salmon'),
                _buildIconText(Icons.rice_bowl_outlined, 'Sushi Rice'),
                _buildIconText(Icons.local_drink_sharp, 'Pepsi'),
              ],
            ),
            SizedBox(height: 16),
            Text(
              '\$$price',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.add),
                Text(
                  '10',
                  style: TextStyle(fontSize: 18),
                ),
                Icon(Icons.remove),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'About Sushi',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Sushi is a Japanese dish of prepared vinegared rice (sushi-meshi), usually with some sugar and salt, plus a variety of ingredients...',
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$$price',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyApp(),
                      ),
                    );
                  },
                  child: Container(
                    width: 150,
                    height: 50,
                    child: Center(
                      child: Text(
                        "Place Order",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconText(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 20),
          SizedBox(width: 4),
          Text(text),
        ],
      ),
    );
  }
}

class OrderConfirmationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Confirmation"),
      ),
      body: Center(
        child: Text(
          "Your order has been placed successfully!",
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
