// Thay thế toàn bộ nội dung của file product_detail_screen.dart bằng đoạn code sau
import 'package:flutter/material.dart';
import 'product_model.dart';
import 'checkout_screen.dart'; // Import màn hình thanh toán
import 'products_screen.dart'; // Import để sử dụng CartItem
import 'order_model.dart'; // Import OrderModel

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  final Function(OrderModel) onCheckoutComplete; // Thêm callback này

  const ProductDetailScreen({
    Key? key,
    required this.product,
    required this.onCheckoutComplete, // Thêm vào constructor
  }) : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
      }
    });
  }

  String _formatCurrency(int amount) {
    String formatted = amount.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
    return '$formatted VNĐ';
  }

  @override
  Widget build(BuildContext context) {
    int price = int.parse(widget.product.price
        .replaceAll(' VNĐ', '')
        .replaceAll('.', ''));
    int totalPrice = price * _quantity;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product.name,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFF4B8C1),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.product.image,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4A4A4A),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.product.price,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFF4B8C1),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Mô tả sản phẩm:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4A4A4A),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.product.description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Số lượng:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4A4A4A),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: _decrementQuantity,
                              icon: const Icon(Icons.remove, size: 20),
                              color: const Color(0xFF4A4A4A),
                            ),
                            Text(
                              '$_quantity',
                              style: const TextStyle(fontSize: 18),
                            ),
                            IconButton(
                              onPressed: _incrementQuantity,
                              icon: const Icon(Icons.add, size: 20),
                              color: const Color(0xFF4A4A4A),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Tạo một CartItem tạm thời
                        final tempCartItem = CartItem(
                          product: widget.product,
                          quantity: _quantity,
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CheckoutScreen(
                              cartItems: [tempCartItem],
                              totalPrice: totalPrice,
                              onCheckoutComplete: (newOrder) {
                                // Gọi callback từ ProductsScreen
                                widget.onCheckoutComplete(newOrder);
                                // Quay lại màn hình sản phẩm chi tiết
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF4B8C1),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Mua ngay',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Đánh giá & Bình luận',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4A4A4A),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const CommentCard(
                    user: 'Khách hàng 1',
                    date: '15/10/2023',
                    comment: 'Sản phẩm rất đẹp và chất lượng, giao hàng nhanh.',
                    rating: 5,
                  ),
                  const CommentCard(
                    user: 'Khách hàng 2',
                    date: '14/10/2023',
                    comment: 'Gỗ chắc chắn, thiết kế hiện đại, rất ưng ý.',
                    rating: 4,
                  ),
                  const CommentCard(
                    user: 'Khách hàng 3',
                    date: '12/10/2023',
                    comment:
                        'Phù hợp với không gian phòng khách nhỏ, giá cả phải chăng.',
                    rating: 3,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CommentCard extends StatelessWidget {
  final String user;
  final String date;
  final String comment;
  final int rating;

  const CommentCard({
    Key? key,
    required this.user,
    required this.date,
    required this.comment,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  user,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF4A4A4A),
                  ),
                ),
                Text(
                  date,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  index < rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 16,
                );
              }),
            ),
            const SizedBox(height: 6),
            Text(
              comment,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}