import 'package:e_com_app/common/widgets/loaders/network_manager.dart';
import 'package:e_com_app/features/personalization/controllers/address_controller.dart';
import 'package:e_com_app/features/shop/controller/product/cart_controller.dart';
import 'package:e_com_app/features/shop/controller/product/checkout_controller.dart';
import 'package:e_com_app/features/shop/controller/product/variation_controller.dart';
import 'package:get/get.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NetworkManager());
    Get.lazyPut(() => VariationController());
    Get.lazyPut(() => CartController());
    Get.put(CheckoutController());
    Get.put(AddressController());
  }
}