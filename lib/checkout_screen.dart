import 'package:flutter/material.dart';
import 'products_screen.dart'; // Import để sử dụng CartItem
import 'order_history_screen.dart'; // Import để điều hướng
import 'order_model.dart';
import 'dart:math';

class CheckoutScreen extends StatefulWidget {
  final List<CartItem> cartItems;
  final int totalPrice;
  final Function(OrderModel) onCheckoutComplete; // Cập nhật tham số này

  const CheckoutScreen({
    Key? key,
    required this.cartItems,
    required this.totalPrice,
    required this.onCheckoutComplete,
  }) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  String _selectedPaymentMethod = 'Thanh toán khi nhận hàng (COD)';

  final List<String> _paymentMethods = [
    'Thanh toán khi nhận hàng (COD)',
    'Thẻ ngân hàng',
    'Ví điện tử',
  ];

  int _discount = 0;
  String _couponCode = '';

  final Map<String, dynamic> _couponCodes = {
    'DOLIALOVE': {'type': 'percent', 'value': 0.15},
    'HAPPY2025': {'type': 'fixed', 'value': 100000},
    'UDAI50K': {'type': 'fixed', 'value': 50000, 'min_price': 300000},
    'PINKYPROMO': {'type': 'percent', 'value': 0.10},
    'FLASHBUY': {'type': 'fixed', 'value': 25000},
    'SUMMER25': {'type': 'percent', 'value': 0.25},
    'NEWYEAR150': {'type': 'fixed', 'value': 150000, 'min_price': 500000},
    'HELLO10': {'type': 'percent', 'value': 0.10},
    'THANKS50': {'type': 'fixed', 'value': 50000, 'min_price': 250000},
  };

  String _formatCurrency(int amount) {
    if (amount < 0) amount = 0;
    String formatted = amount.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
    return '$formatted VNĐ';
  }

  void _applyCoupon(String code) {
    setState(() {
      final couponData = _couponCodes[code];
      _couponCode = code;

      if (code == 'UDAI50K' && widget.totalPrice < couponData['min_price']) {
        _discount = 0;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Mã này chỉ áp dụng cho đơn hàng trên 300.000 VNĐ.'),
            backgroundColor: Colors.orange,
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }

      if (couponData['type'] == 'percent') {
        _discount = (widget.totalPrice * couponData['value']).round();
      } else {
        _discount = couponData['value'];
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Mã giảm giá "$code" đã được áp dụng!'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
    });
  }

  void _showCouponDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Chọn mã giảm giá'),
          children: _couponCodes.keys.map((String key) {
            final couponData = _couponCodes[key];
            String description = '';
            if (couponData['type'] == 'percent') {
              description =
                  'Giảm ${((couponData['value'] as double) * 100).round()}%';
            } else {
              description = 'Giảm ${_formatCurrency(couponData['value'])}';
            }
            if (couponData.containsKey('min_price')) {
              description +=
                  ' (ĐH > ${_formatCurrency(couponData['min_price'])})';
            }
            return SimpleDialogOption(
              onPressed: () {
                _applyCoupon(key);
                Navigator.pop(context);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    key,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    description,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int finalPrice = widget.totalPrice - _discount;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thanh Toán',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFF4B8C1),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Thông tin giao hàng',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4A4A4A),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Số điện thoại',
                hintText: 'Nhập số điện thoại của bạn',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.phone),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _addressController,
              decoration: InputDecoration(
                labelText: 'Địa chỉ',
                hintText: 'Nhập địa chỉ giao hàng',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.location_on),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 32),
            const Text(
              'Phương thức thanh toán',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4A4A4A),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: _selectedPaymentMethod,
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedPaymentMethod = newValue!;
                    });
                  },
                  items: _paymentMethods.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Mã giảm giá',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4A4A4A),
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: _showCouponDialog,
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _couponCode.isEmpty
                          ? 'Chọn hoặc nhập mã giảm giá'
                          : _couponCode,
                      style: TextStyle(
                        fontSize: 16,
                        color: _couponCode.isEmpty ? Colors.grey : Colors.black,
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios,
                        size: 16, color: Colors.grey),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Tóm tắt đơn hàng',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF4B8C1),
              ),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final item = widget.cartItems[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          item.product.image,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          '${item.product.name} x${item.quantity}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      Text(
                        _formatCurrency(int.parse(item.product.price
                                .replaceAll(' VNĐ', '')
                                .replaceAll('.', '')) *
                            item.quantity),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              },
            ),
            const Divider(height: 32, thickness: 1.5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Tổng phụ:',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  _formatCurrency(widget.totalPrice),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Giảm giá ($_couponCode):',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                  ),
                ),
                Text(
                  '- ${_formatCurrency(_discount)}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(height: 1, thickness: 1.5),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Tổng cộng:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4A4A4A),
                  ),
                ),
                Text(
                  _formatCurrency(finalPrice),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF4B8C1),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final phoneNumber = _phoneController.text;
                  final address = _addressController.text;
                  if (phoneNumber.isEmpty || address.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('Vui lòng nhập đầy đủ thông tin giao hàng.'),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 2),
                      ),
                    );
                    return;
                  }

                  // Tạo một đối tượng OrderModel từ dữ liệu hiện tại
                  final newOrder = OrderModel(
                    orderId:
                        'DH${Random().nextInt(99999).toString().padLeft(5, '0')}',
                    date:
                        '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                    status: 'Đang xử lý',
                    total: _formatCurrency(finalPrice),
                    deliveryAddress: address,
                    paymentMethod: _selectedPaymentMethod,
                    products: widget.cartItems
                        .map((item) => OrderItem(
                              productName: item.product.name,
                              image: item.product.image,
                              price: item.product.price,
                              quantity: item.quantity,
                            ))
                        .toList(),
                  );

                  // Gọi hàm callback và truyền đối tượng đơn hàng mới
                  widget.onCheckoutComplete(newOrder);

                  // Hiển thị SnackBar và điều hướng
                  final snackBar = const SnackBar(
                    content: Text('Đơn hàng đã được đặt thành công!'),
                    backgroundColor: Color(0xFFF4B8C1),
                    duration: Duration(seconds: 2),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  // Đóng màn hình thanh toán
                  Navigator.pop(context);

                  // Sau khi pop, điều hướng đến màn hình lịch sử đơn hàng.
                  // Vì OrderHistoryScreen đã có dữ liệu từ _orderHistory được truyền vào,
                  // nên màn hình sẽ tự động hiển thị đơn hàng mới.
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF4B8C1),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Xác nhận thanh toán',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}