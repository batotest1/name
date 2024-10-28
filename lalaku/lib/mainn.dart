import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant Cart',
      home: CartScreen(),
    );
  }
}

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<CartItemData> cartItems = [
    CartItemData(name: 'Original Sushi', price: 26.00, quantity: 1),
    CartItemData(name: 'California Roll', price: 18.00, quantity: 1),
    CartItemData(name: 'Salmon Roll', price: 22.50, quantity: 1),
  ];

  double get totalPrice => cartItems.fold(
      0.0, (total, item) => total + (item.price * item.quantity));

  void updateQuantity(int index, int newQuantity) {
    setState(() {
      cartItems[index].quantity = newQuantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Your Cart Food')),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            ...cartItems.asMap().entries.map((entry) {
              int index = entry.key;
              CartItemData item = entry.value;
              return CartItem(
                name: item.name,
                price: item.price,
                quantity: item.quantity,
                onChanged: (value) => updateQuantity(index, value),
              );
            }).toList(),
            Divider(),
            _buildTotalRow('Delivery:', 0.00, delivery: true),
            _buildTotalRow('Item Total:', totalPrice),
            Divider(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Payment action can be implemented here
              },
              child: Text('Payment'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalRow(String label, double amount, {bool delivery = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Text(delivery ? 'Free' : '\$${amount.toStringAsFixed(2)}'),
      ],
    );
  }
}

class CartItemData {
  final String name;
  final double price;
  int quantity;

  CartItemData({
    required this.name,
    required this.price,
    required this.quantity,
  });
}

class CartItem extends StatelessWidget {
  final String name;
  final double price;
  final int quantity;
  final ValueChanged<int> onChanged;

  const CartItem({
    required this.name,
    required this.price,
    required this.quantity,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: TextStyle(fontSize: 18)),
              Text('\$${price.toStringAsFixed(2)}'),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  if (quantity > 1) onChanged(quantity - 1);
                },
              ),
              Text(quantity.toString()),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => onChanged(quantity + 1),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
