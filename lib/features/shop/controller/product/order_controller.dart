
import 'package:e_com_app/common/widgets/loaders/loaders.dart';
import 'package:e_com_app/common/widgets/success_screen/success_screen.dart';
import 'package:e_com_app/data/repositories/authentication/authenication_repository.dart';
import 'package:e_com_app/data/repositories/order/order_repository.dart';
import 'package:e_com_app/features/personalization/controllers/address_controller.dart';
import 'package:e_com_app/features/shop/controller/product/cart_controller.dart';
import 'package:e_com_app/features/shop/controller/product/checkout_controller.dart';
import 'package:e_com_app/features/shop/models/order_model.dart';
import 'package:e_com_app/navigation_menu.dart';
import 'package:e_com_app/util/constants/enums.dart';
import 'package:e_com_app/util/constants/image_strings.dart';
import 'package:e_com_app/util/popups/EFullScreenLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();
  
  final cartController = CartController.instance;
  final addressController = AddressController.instance;
  final checkoutController = CheckoutController.instance;
  final orderRepository = Get.put(OrderRepository());
  
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userOrders = await orderRepository.fetchUserOrders();
      return userOrders;
    } catch (e) {
      ELoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }
  
  void processOrder(double totalAmount) async {
    try {
      EFullScreenLoader.openLoadingDialog('Processing your order', EImages.orderProcess);

      final userId = AuthenticationRepository.instance.authUser.uid;
      if (userId.isEmpty) return;

      final order = OrderModel(
          id: UniqueKey().toString(),
          userId: userId,
          status: OrderStatus.pending,
          totalAmount: totalAmount,
          orderDate: DateTime.now(),
          paymentMethod: checkoutController.selectedPaymentMethod.value.name,
          address: addressController.selectedAddress.value,

          deliveryDate: DateTime.now(),
          items: cartController.cartItems.toList(),
      );

      await orderRepository.saveOrder(order, userId);

      cartController.clearCart();

      Get.off(() => SuccessScreen(
        image: EImages.successPayment,
        title: 'Payment Success!',
        subTitle: 'Your item will be shipped soon!',
        onPressed: () => Get.offAll(() => const NavigationMenu()),
      ));
    } catch (e) {
      ELoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}