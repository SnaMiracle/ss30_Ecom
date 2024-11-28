import 'package:e_com_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:e_com_app/common/widgets/loaders/animation_loader.dart';
import 'package:e_com_app/features/shop/controller/product/order_controller.dart';
import 'package:e_com_app/features/shop/models/order_model.dart';
import 'package:e_com_app/navigation_menu.dart';
import 'package:e_com_app/util/constants/colors.dart';
import 'package:e_com_app/util/constants/image_strings.dart';
import 'package:e_com_app/util/constants/sizes.dart';
import 'package:e_com_app/util/helpers/cloud_helper_functions.dart';
import 'package:e_com_app/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class EOrderListItems extends StatelessWidget {
  const EOrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    return FutureBuilder<List<OrderModel>>(
      future: controller.fetchUserOrders(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while waiting for data
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          // Handle error state
          return Center(
            child: Text(
              'Something went wrong! Please try again.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        }

        if (!snapshot.hasData || (snapshot.data?.isEmpty ?? true)) {
          // Handle empty data state
          return EAnimationLoaderWidget(
            text: 'Whoops! No orders Yet!',
            animation: EImages.successPayment,
            showAction: true,
            actionText: 'Let\'s fill it',
            onActionPressed: () => Get.off(() => const NavigationMenu()),
          );
        }

        // Handle the case when data is available
        final orders = snapshot.data!;
        return ListView.separated(
          shrinkWrap: true,
          itemCount: orders.length,
          separatorBuilder: (_, index) => const SizedBox(height: ESizes.spaceBtwItems),
          itemBuilder: (_, index) {
            final order = orders[index];
            return ERoundedContainer(
              showBorder: true,
              padding: const EdgeInsets.all(ESizes.md),
              backgroundColor: EHelperFunctions.isDarkMode(context) ? EColors.dark : EColors.light,
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Iconsax.ship),
                      const SizedBox(width: ESizes.spaceBtwItems / 2),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.orderStatusText,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyLarge!.apply(
                                  color: EColors.primary, fontWeightDelta: 1),
                            ),
                            Text(order.formattedOrderDate, style: Theme.of(context).textTheme.headlineSmall),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Iconsax.arrow_right_34, size: ESizes.iconSm),
                      ),
                    ],
                  ),
                  const SizedBox(height: ESizes.spaceBtwItems),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(Iconsax.tag),
                            const SizedBox(width: ESizes.spaceBtwItems / 2),
                            Flexible(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Order',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context).textTheme.labelMedium),
                                  Text(order.id,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context).textTheme.titleMedium),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(Iconsax.calendar),
                            const SizedBox(width: ESizes.spaceBtwItems / 2),
                            Flexible(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Shipping Date',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context).textTheme.labelMedium),
                                  Text(order.formattedDeliveryDate,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context).textTheme.titleMedium),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}