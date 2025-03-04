import 'package:e_com_app/common/widgets/image_text_widgets/vertical_image_text.dart';
import 'package:e_com_app/common/widgets/success_screen/category_shimmer.dart';
import 'package:e_com_app/features/shop/controller/category_controller.dart';
import 'package:e_com_app/features/shop/screens/sub_category/sub_categories.dart';
import 'package:e_com_app/util/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EHomeCategories extends StatelessWidget {
  const EHomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());


    return Obx(() {
      if (categoryController.isLoading.value) return const ECategoryShimmer();

      if (categoryController.featuredCategories.isEmpty) {
        return Center(child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white)));
      }
        return SizedBox(
          height: 90,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: categoryController.featuredCategories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) {
              final category = categoryController.featuredCategories[index];
              return EVerticalImageText(
                  image: category.image,
                  title: category.name,
                  onTap: () => Get.to(() => SubCategoriesScreen(category: category)),
              );
            },
          ),
        );
      }
    );
  }
}