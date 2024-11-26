import 'package:e_com_app/common/widgets/appbar/appbar.dart';
import 'package:e_com_app/features/shop/screens/order/widgets/orders_list.dart';
import 'package:e_com_app/util/constants/sizes.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EAppBar(title: Text('MyOrders', style: Theme.of(context).textTheme.headlineSmall), showBackArrow: true),
      body: const Padding(
          padding: EdgeInsets.all(ESizes.defaultSpace),

        ///--orders
        child: EOrderListItems(),
      ),
    );
  }
}
