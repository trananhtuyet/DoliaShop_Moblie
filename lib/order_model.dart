// File: order_model.dart

class OrderItem {
  final String productName;
  final String image; // Tên biến đã được sửa thành 'image'
  final String price;
  final int quantity;

  OrderItem({
    required this.productName,
    required this.image, // Tên tham số cũng là 'image'
    required this.price,
    required this.quantity,
  });
}

class OrderModel {
  final String orderId;
  final String date;
  final String status;
  final String total;
  final String deliveryAddress;
  final String paymentMethod;
  final List<OrderItem> products;

  OrderModel({
    required this.orderId,
    required this.date,
    required this.status,
    required this.total,
    required this.deliveryAddress,
    required this.paymentMethod,
    required this.products,
  });
}