import 'package:e_com_app/common/widgets/appbar/appbar.dart';
import 'package:e_com_app/common/widgets/products/ratings/rating_indicator.dart';
import 'package:e_com_app/util/constants/sizes.dart';
import 'package:flutter/material.dart';


import 'widgets/rating_progress_indicatior.dart';
import 'widgets/user_review_card.dart';

class ProductReviewScreen extends StatelessWidget {
  const ProductReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///-- appbar
      appBar: const EAppBar(title: Text('Reviews & Ratings'), showBackArrow: true),
      
      ///-- body
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(ESizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Ratings and reviews are verified and are from people who use the same type of device that you use."),
              const SizedBox(height: ESizes.spaceBtwItems),

              ///-- rating product
              const EOverallProductRating(),
              const ERatingBarIndicator(rating: 3.5),
              Text("12,611", style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: ESizes.spaceBtwSections),

              ///--user review
              const UserReviewCard(),
              const UserReviewCard(),
              const UserReviewCard(),
              const UserReviewCard(),
            ],
          ),
        ),
      ),
    );
  }
}





