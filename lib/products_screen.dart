// Thay thế toàn bộ nội dung của file products_screen.dart bằng đoạn code sau
import 'package:flutter/material.dart';
import 'package:dolia_app/account_details_screen.dart';
import 'package:dolia_app/product_model.dart';
import 'package:dolia_app/cart_screen.dart';
import 'package:collection/collection.dart';
import 'package:dolia_app/checkout_screen.dart';
import 'product_detail_screen.dart';
import 'order_history_screen.dart';
import 'contact_screen.dart';
import 'order_model.dart';
import 'main.dart';
import 'dart:async';

// Class CartItem để quản lý sản phẩm và số lượng
class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

void main() {
  runApp(const DoliaApp());
}

class DoliaApp extends StatelessWidget {
  const DoliaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dolia Shop',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        fontFamily: 'Roboto',
      ),
      home: ProductsScreen(),
    );
  }
}

// Màn hình sản phẩm yêu thích
class FavoriteScreen extends StatelessWidget {
  final List<Product> favoriteProducts;
  final Function(OrderModel) onCheckoutComplete;

  const FavoriteScreen({
    Key? key,
    required this.favoriteProducts,
    required this.onCheckoutComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sản phẩm yêu thích',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFF4B8C1),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: favoriteProducts.isEmpty
          ? const Center(
              child: Text(
                'Bạn chưa có sản phẩm yêu thích nào.',
                style: TextStyle(fontSize: 18, color: Color(0xFF4A4A4A)),
              ),
            )
          : ListView.builder(
              itemCount: favoriteProducts.length,
              itemBuilder: (context, index) {
                final product = favoriteProducts[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(8.0),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        product.image,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      product.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(product.price),
                    trailing: const Icon(Icons.favorite, color: Colors.red),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(
                            product: product,
                            onCheckoutComplete:
                                onCheckoutComplete, // Thêm tham số này
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}

// Màn hình sản phẩm chính
class ProductsScreen extends StatefulWidget {
  ProductsScreen({Key? key}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  // Thêm category vào danh sách sản phẩm
  final List<Product> products = [
    Product(
      name: 'Ghế sofa hiện đại',
      image:
          'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNTY1MHwwfDF8c2VhcmNofDE3fHxzb2ZhfGVufDB8fHx8MTY3ODk1MDc0Ng&ixlib=rb-4.0.3&q=80&w=400',
      price: '15.000.000 VNĐ',
      description:
          'Ghế sofa hiện đại, bọc vải nỉ cao cấp. Thiết kế tối giản, phù hợp với mọi không gian phòng khách. Khung gỗ chắc chắn, đệm mút êm ái mang lại cảm giác thoải mái tối đa.',
      category: 'Nội thất',
    ),
    Product(
      name: 'Bàn ăn gỗ tự nhiên',
      image:
          'https://govi.vn/wp-content/uploads/2022/06/tam-quan-trong-cua-ban-an.jpg?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNTY1MHwwfDF8c2VhcmNofDEzfHxkaW5pbmclMjB0YWJsZXxlbnwwfHx8fDE2Nzg5NTEyMjI&ixlib=rb-4.0.3&q=80&w=400',
      price: '12.500.000 VNĐ',
      description:
          'Bàn ăn làm từ gỗ tự nhiên 100%, vân gỗ đẹp mắt. Bề mặt được xử lý chống thấm, chống xước. Thiết kế chắc chắn, bền đẹp theo thời gian.',
      category: 'Nội thất',
    ),
    Product(
      name: 'Tủ quần áo tối giản',
      image:
          'https://noithatsonghong.vn/content/images/thumbs/0001345_tu-quan-ao-ket-hop-canh-kinh-dep_300.png?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNTY1MHwwfDF8c2VhcmNofDEzfHxkaW5pbmclMjB0YWJsZXxlbnwwfHx8fDE2Nzg5NTEyMjI&ixlib=rb-4.0.3&q=80&w=400',
      price: '8.000.000 VNĐ',
      description:
          'Tủ quần áo với thiết kế tối giản, nhiều ngăn tiện lợi. Chất liệu gỗ công nghiệp cao cấp, chống ẩm mốc. Phù hợp cho những không gian nhỏ, giúp tiết kiệm diện tích.',
      category: 'Nội thất',
    ),
    Product(
      name: 'Kệ sách đa năng',
      image:
          'https://product.hstatic.net/1000078439/product/0_40e9ad93f03247168508b8ed9e137b36_large.jpg?v=1722573519027?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNTY1MHwwfDF8c2VhcmNofDIwfHxib29rc2hlbGZ8ZW58MHx8fHwxNjc4OTUxODcz&ixlib=rb-4.0.3&q=80&w=400',
      price: '6.500.000 VNĐ',
      description:
          'Kệ sách được thiết kế đa năng, có thể dùng để sách, trang trí hoặc đặt các vật dụng khác. Khung kim loại chắc chắn, các ngăn gỗ công nghiệp bền đẹp.',
      category: 'Nội thất',
    ),
    Product(
      name: 'Đèn trần phong cách',
      image:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRF00fc-uxP5FLmcBrDMcoLgTWLMOgwnbhLdQ&s?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNTY1MHwwfDF8fG9sZCUyMGxpZ2h0aW5nfGVufDB8fHx8MTY3ODk1MjM4NQ&ixlib=rb-4.0.3&q=80&w=400',
      price: '3.200.000 VNĐ',
      description:
          'Đèn trần được thiết kế hiện đại, mang lại ánh sáng ấm áp, tạo điểm nhấn cho không gian sống. Chất liệu cao cấp, bền đẹp theo thời gian.',
      category: 'Trang trí',
    ),
    Product(
      name: 'Bộ chăn ga gối',
      image:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSoG_BRyd0X_VFF-YZV8_hK2X_eouCpsfT1FA&s?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNTY1MHwwfDF8fGJlZGRpbmclMjBzZXR8ZW58MHx8fHwxNjc4OTUyOTE3&ixlib=rb-4.0.3&q=80&w=400',
      price: '4.500.000 VNĐ',
      description:
          'Bộ chăn ga gối làm từ cotton 100% tự nhiên, mềm mại, thoáng mát, mang lại giấc ngủ ngon. Họa tiết tinh tế, trang nhã.',
      category: 'Đồ dùng',
    ),
    Product(
      name: 'Thảm trải sàn',
      image:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpO9g6UNT4HkHa7-t47cQ-lpZ62YGxntdwZebHPPzO-FD48473mBmOZ4BfPCY6aElis1Y&usqp=CAU?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNTY1MHwwfDF8c2VhcmNofDE1fHxjYXJwZXR8ZW58MHx8fHwxNjc4OTUzMDA0&ixlib=rb-4.0.3&q=80&w=400',
      price: '2.800.000 VNĐ',
      description:
          'Thảm trải sàn cao cấp, sợi dệt dày dặn, bền màu, chống trơn trượt. Họa tiết hình học hiện đại, phù hợp với nhiều phong cách nội thất.',
      category: 'Trang trí',
    ),
    Product(
      name: 'Bàn trà nhỏ',
      image:
          'https://bizweb.dktcdn.net/100/407/310/products/ban-tra-nho-233s.jpg?v=1722573519027?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNTY1MHwwfDF8c2VhcmNofDI0fHxlbGVnYW50JTIwY29mZmVlJTIwdGFibGV8ZW58MHx8fHwxNjc4OTUzNDM1&ixlib=rb-4.0.3&q=80&w=400',
      price: '7.500.000 VNĐ',
      description:
          'Bàn trà nhỏ gọn, tiện lợi, phù hợp với không gian phòng khách nhỏ. Khung kim loại chắc chắn, mặt bàn bằng kính cường lực bền đẹp.',
      category: 'Nội thất',
    ),
    Product(
      name: 'Gương treo tường',
      image:
          'https://s3.img-b.com/image/private/t_base,c_lpad,f_auto,dpr_auto,w_70,h_70/product/renwil/MT2365-lifestyle.jpg?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNTY1MHwwfDF8c2VhcmNofDEwfHx3YWxsJTIwbWlycm9yfGVufDB8fHx8MTY5MDAwNzEwMA&ixlib=rb-4.0.3&q=80&w=400',
      price: '1.500.000 VNĐ',
      description:
          'Gương treo tường với khung kim loại chắc chắn, thiết kế tối giản, mang lại vẻ đẹp hiện đại cho không gian. Có nhiều kích thước để lựa chọn.',
      category: 'Trang trí',
    ),
  ];

  final List<String> _bannerImages = [
    'https://cdn.printnetwork.com/production/assets/5966561450122033bd4456f8/imageLocker/blog-description/blog/sales_banners.jpg?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://as1.ftcdn.net/jpg/03/92/21/08/1000_F_392210849_zvZWVAqKVhsBK8sCR2oC8jl2ZpRDyNro.jpg?q=80&w=1965&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJ3BWjWaQ4KoTtNhE6LutSPkafYVVC53Ck3POAetNe_PeU60jztA3DmQDTjTrgDysbH9Q&usqp=CAU?q=80&w=1964&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  ];

  late List<bool> _isFavoriteList;
  final List<CartItem> _cartItems = [];
  final List<OrderModel> _orderHistory = [];

  // Thêm biến trạng thái để quản lý tìm kiếm và danh mục
  String _searchQuery = '';
  String _selectedCategory = 'Tất cả';

  // Thêm các biến mới để quản lý banner
  final PageController _pageController = PageController();
  late Timer _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _isFavoriteList = List<bool>.filled(products.length, false);

    // Khởi tạo timer để tự động chuyển trang
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < _bannerImages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeIn,
      );
    });
  }

  // Luôn luôn hủy timer khi màn hình bị đóng
  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  // Lọc sản phẩm dựa trên tìm kiếm và danh mục
  List<Product> get _filteredProducts {
    List<Product> filtered = products;

    if (_selectedCategory != 'Tất cả') {
      filtered = filtered
          .where((product) => product.category == _selectedCategory)
          .toList();
    }

    if (_searchQuery.isNotEmpty) {
      filtered = filtered
          .where((product) =>
              product.name.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }
    return filtered;
  }

  // Hàm xử lý khi cập nhật số lượng
  void _onUpdateQuantity(CartItem item, int newQuantity) {
    setState(() {
      if (newQuantity <= 0) {
        _cartItems.remove(item);
      } else {
        item.quantity = newQuantity;
      }
    });
  }

  // Hàm xử lý khi xóa sản phẩm khỏi giỏ hàng
  void _onRemoveFromCart(CartItem item) {
    setState(() {
      _cartItems.remove(item);
    });
  }

  // Cập nhật hàm này để nhận đơn hàng mới và thêm vào lịch sử
  void _onCheckoutComplete(OrderModel newOrder) {
    setState(() {
      _cartItems.clear(); // Xóa giỏ hàng sau khi thanh toán
      _orderHistory.add(newOrder); // Thêm đơn hàng mới vào lịch sử
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dolia Shop',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFF4B8C1),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Badge(
              label: Text(_cartItems.length.toString()),
              child: const Icon(Icons.shopping_cart),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(
                    cartItems: _cartItems,
                    onUpdateQuantity: _onUpdateQuantity,
                    onRemove: _onRemoveFromCart,
                    onCheckoutComplete:
                        _onCheckoutComplete, // Truyền hàm callback
                  ),
                ),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFF4B8C1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child:
                        Icon(Icons.person, size: 40, color: Color(0xFFF4B8C1)),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Chào mừng, Người dùng!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Chi tiết tài khoản'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AccountDetailsScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Sản phẩm yêu thích'),
              onTap: () {
                Navigator.pop(context);
                final List<Product> favoriteList = [];
                for (int i = 0; i < products.length; i++) {
                  if (_isFavoriteList[i]) {
                    favoriteList.add(products[i]);
                  }
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FavoriteScreen(
                            favoriteProducts: favoriteList,
                            onCheckoutComplete:
                                _onCheckoutComplete, // Thêm tham số này
                          )),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_bag_outlined),
              title: const Text('Đơn hàng'),
              onTap: () {
                Navigator.pop(context); // Đóng menu
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderHistoryScreen(
                        orders: _orderHistory), // Truyền danh sách đơn hàng
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.chat),
              title: const Text('Liên hệ với shop'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ContactScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Đăng xuất'),
              onTap: () {
                // Đóng Drawer
                Navigator.pop(context);
                // Điều hướng đến LoginScreen và xóa tất cả các màn hình trước đó
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (Route<dynamic> route) =>
                      false, // Điều này đảm bảo tất cả các route cũ được xóa
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Tìm kiếm sản phẩm...',
                prefixIcon: const Icon(Icons.search, color: Color(0xFFF4B8C1)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Danh mục sản phẩm
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                _buildCategoryChip('Tất cả'),
                const SizedBox(width: 8),
                _buildCategoryChip('Nội thất'),
                const SizedBox(width: 8),
                _buildCategoryChip('Trang trí'),
                const SizedBox(width: 8),
                _buildCategoryChip('Đồ dùng'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Banner quảng cáo chạy ngang thủ công
          SizedBox(
            height: 120,
            child: PageView.builder(
              controller: _pageController,
              itemCount: _bannerImages.length,
              itemBuilder: (context, index) {
                final imageUrl = _bannerImages[index];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: _filteredProducts.isEmpty
                ? const Center(
                    child: Text(
                      'Không tìm thấy sản phẩm nào.',
                      style: TextStyle(fontSize: 18, color: Color(0xFF4A4A4A)),
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: _filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = _filteredProducts[index];
                      final originalIndex = products.indexOf(product);
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailScreen(
                                product: product,
                                onCheckoutComplete:
                                    _onCheckoutComplete, // Truyền callback vào đây
                              ),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(12)),
                                      child: Image.network(
                                        product.image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.name,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF4A4A4A),
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          product.price,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Color(0xFFF4B8C1),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF7F3F0)
                                            .withOpacity(0.8),
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            offset: const Offset(2, 2),
                                            blurRadius: 4,
                                          ),
                                        ],
                                      ),
                                      child: IconButton(
                                        icon: Icon(
                                          _isFavoriteList[originalIndex]
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          size: 20,
                                          color: _isFavoriteList[originalIndex]
                                              ? Colors.red
                                              : const Color(0xFFF4B8C1),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _isFavoriteList[originalIndex] =
                                                !_isFavoriteList[originalIndex];
                                          });
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(_isFavoriteList[
                                                      originalIndex]
                                                  ? 'Đã thêm vào mục yêu thích!'
                                                  : 'Đã xóa khỏi mục yêu thích!'),
                                              backgroundColor:
                                                  const Color(0xFFF4B8C1),
                                              duration:
                                                  const Duration(seconds: 1),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF7F3F0)
                                            .withOpacity(0.8),
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            offset: const Offset(2, 2),
                                            blurRadius: 4,
                                          ),
                                        ],
                                      ),
                                      child: IconButton(
                                        icon: const Icon(Icons.shopping_cart,
                                            size: 20, color: Color(0xFFF4B8C1)),
                                        onPressed: () {
                                          setState(() {
                                            final existingItem = _cartItems
                                                .firstWhereOrNull((item) =>
                                                    item.product.name ==
                                                    product.name);
                                            if (existingItem != null) {
                                              existingItem.quantity++;
                                            } else {
                                              _cartItems.add(
                                                  CartItem(product: product));
                                            }
                                          });
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Đã thêm "${product.name}" vào giỏ hàng thành công!'),
                                              backgroundColor:
                                                  const Color(0xFFF4B8C1),
                                              duration:
                                                  const Duration(seconds: 2),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
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

  // Widget để xây dựng các chip danh mục
  Widget _buildCategoryChip(String title) {
    final bool isSelected = _selectedCategory == title;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedCategory = title;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF4B8C1) : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}