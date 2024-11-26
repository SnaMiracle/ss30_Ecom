 import 'package:e_com_app/common/widgets/loaders/loaders.dart';
import 'package:e_com_app/data/repositories/banners/banner_repository.dart';
import 'package:e_com_app/features/shop/models/banner_model.dart';
import 'package:get/get.dart';

class BannerController extends GetxController {

  final isLoading = false.obs;
  final carousalCurrentIndex = 0.obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs;


  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

  void updatePageIndicator(index) {
    carousalCurrentIndex.value = index;
  }

  ///--fetch banner
  Future<void> fetchBanners() async {
    try {

      isLoading.value = true;

      final bannerRepo = Get.put(BannerRepository());
      final banners = await bannerRepo.fetchBanner();

      ///--assign banners
      this.banners.assignAll(banners);

    } catch (e) {
      ELoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}