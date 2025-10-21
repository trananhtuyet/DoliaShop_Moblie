import 'package:flutter/material.dart';
import 'order_model.dart';

class OrderHistoryScreen extends StatelessWidget {
  final List<OrderModel> orders; // Thêm tham số này
  const OrderHistoryScreen({super.key, required this.orders});

  // Dữ liệu đơn hàng mẫu để hiển thị
  List<OrderModel> get _sampleOrders {
    return [
      OrderModel(
        orderId: 'DH001',
        date: '22/09/2025',
        status: 'Đã giao hàng',
        total: '1.250.000 VNĐ',
        deliveryAddress: 'Số 123, đường Láng, Đống Đa, Hà Nội',
        paymentMethod: 'Thanh toán khi nhận hàng',
        products: [
          OrderItem(
            productName: 'Ghế gỗ tựa lưng',
            image:
                'https://file.hstatic.net/1000288788/file/ghe-go-tua-lung__1__068ef7e7fdcd45a5a14d652304b1dbb8.png?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNTY1MHwwfDF8c2VhcmNofDEzfHxkaW5pbmclMjB0YWJsZXxlbnwwfHx8fDE2Nzg5NTEyMjI&ixlib=rb-4.0.3&q=80&w=400',
            price: '750.000 VNĐ',
            quantity: 1,
          ),
          OrderItem(
            productName: 'Bàn trà nhỏ',
            image:
                'https://file.hstatic.net/1000288788/file/ghe-go-tua-lung__1__068ef7e7fdcd45a5a14d652304b1dbb8.png?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNTY1MHwwfDF8c2VhcmNofDEzfHxkaW5pbmclMjB0YWJsZXxlbnwwfHx8fDE2Nzg5NTEyMjI&ixlib=rb-4.0.3&q=80&w=400',
            price: '500.000 VNĐ',
            quantity: 1,
          ),
        ],
      ),
      OrderModel(
        orderId: 'DH002',
        date: '20/09/2025',
        status: 'Đang vận chuyển',
        total: '2.500.000 VNĐ',
        deliveryAddress: 'Số 456, đường Lê Lợi, Quận 1, TP.HCM',
        paymentMethod: 'Chuyển khoản ngân hàng',
        products: [
          OrderItem(
            productName: 'Tủ gỗ nhiều ngăn',
            image:
                'https://file.hstatic.net/1000288788/file/ghe-go-tua-lung__1__068ef7e7fdcd45a5a14d652304b1dbb8.png?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNTY1MHwwfDF8c2VhcmNofDEzfHxkaW5pbmclMjB0YWJsZXxlbnwwfHx8fDE2Nzg5NTEyMjI&ixlib=rb-4.0.3&q=80&w=400',
            price: '2.500.000 VNĐ',
            quantity: 1,
          ),
        ],
      ),
      OrderModel(
        orderId: 'DH003',
        date: '15/09/2025',
        status: 'Đã hủy',
        total: '750.000 VNĐ',
        deliveryAddress: 'Số 789, đường Trần Hưng Đạo, Quận Hoàn Kiếm, Hà Nội',
        paymentMethod: 'Thẻ tín dụng',
        products: [
          OrderItem(
            productName: 'Kệ sách mini',
            image:
                'https://file.hstatic.net/1000288788/file/ghe-go-tua-lung__1__068ef7e7fdcd45a5a14d652304b1dbb8.png?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNTY1MHwwfDF8c2VhcmNofDEzfHxkaW5pbmclMjB0YWJsZXxlbnwwfHx8fDE2Nzg5NTEyMjI&ixlib=rb-4.0.3&q=80&w=400',
            price: '750.000 VNĐ',
            quantity: 1,
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lịch sử đơn hàng',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFF4B8C1),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _sampleOrders.isEmpty
          ? const Center(
              child: Text(
                'Bạn chưa có đơn hàng nào.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _sampleOrders.length,
              itemBuilder: (context, index) {
                return OrderCard(order: _sampleOrders[index]);
              },
            ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final OrderModel order;

  const OrderCard({super.key, required this.order});

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Đã giao hàng':
        return Colors.green;
      case 'Đang vận chuyển':
        return Colors.blue;
      case 'Đã hủy':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'Đã giao hàng':
        return Icons.check_circle;
      case 'Đang vận chuyển':
        return Icons.local_shipping;
      case 'Đã hủy':
        return Icons.cancel;
      default:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ExpansionTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Mã đơn hàng: ${order.orderId}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4A4A4A),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(order.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _getStatusIcon(order.status),
                        color: _getStatusColor(order.status),
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        order.status,
                        style: TextStyle(
                          fontSize: 12,
                          color: _getStatusColor(order.status),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Tổng tiền: ${order.total}',
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFFF4B8C1),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Ngày đặt hàng: ${order.date}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        children: [
          const Divider(height: 1, indent: 16, endIndent: 16),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Sản phẩm đã mua:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ...order.products.map((item) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              item.image,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.productName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '${item.quantity} x ${item.price}',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                const SizedBox(height: 16),
                const Text(
                  'Thông tin giao hàng:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text('Địa chỉ: ${order.deliveryAddress}'),
                Text('Phương thức thanh toán: ${order.paymentMethod}'),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('Đang thêm các sản phẩm vào giỏ hàng...'),
                          backgroundColor: Color(0xFFF4B8C1),
                        ),
                      );
                    },
                    icon: const Icon(Icons.refresh, color: Colors.white),
                    label: const Text(
                      'Mua lại đơn hàng',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF4B8C1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
