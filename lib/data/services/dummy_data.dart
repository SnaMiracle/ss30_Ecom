import 'package:e_com_app/features/shop/models/banner_model.dart';
import 'package:e_com_app/features/shop/models/brand_model.dart';
import 'package:e_com_app/features/shop/models/category_model.dart';
import 'package:e_com_app/features/shop/models/product_attribute_model.dart';
import 'package:e_com_app/features/shop/models/product_model.dart';
import 'package:e_com_app/features/shop/models/product_variation_model.dart';
import 'package:e_com_app/routes/routes.dart';
import 'package:e_com_app/util/constants/image_strings.dart';

class EDummyData {

  static final List<CategoryModel> categories = [
    CategoryModel(id: '1', name: 'Shirt', image: EImages.shirtIcon, isFeatured: true),
    CategoryModel(id: '2', name: 'Wallet', image: EImages.walletIcon, isFeatured: true),
    CategoryModel(id: '3', name: 'Purse', image: EImages.womenPurseIcon, isFeatured: true),
    CategoryModel(id: '4', name: 'Briefcase', image: EImages.briefCaseIcon, isFeatured: true),
    CategoryModel(id: '5', name: 'Shoes', image: EImages.shoeIcon, isFeatured: true),
    CategoryModel(id: '6', name: 'Watches', image: EImages.watchIcon, isFeatured: true),
    CategoryModel(id: '7', name: 'Sun Glasses', image: EImages.sunGlassesIcon, isFeatured: true),
    CategoryModel(id: '8', name: 'Pants', image: EImages.pantIcon, isFeatured: true),
  ];

  // static final List<CategoryModel> banners = [
  //   BannerModel(imageUrl: EImages.promotionBanner1, targetScreen: ERoutes.cart, active: false),
  //   BannerModel(imageUrl: EImages.promotionBanner2, targetScreen: ERoutes.search, active: true),
  // ];

  static final List<ProductModel> products = [
    ProductModel(
        id: '001',
        title: 'Nike Air Shoes',
        stock: 15,
        price: 135,
        isFeatured: true,
        thumbnail: EImages.productImage1,
        description: 'Sport Shoes for running.',
        brand: BrandModel(id: '1', image: EImages.nikeIcon, name: 'Nike', productsCount: 265, isFeatured: true),
        images: [EImages.productImage1, EImages.productImage2, EImages.productImage3],
        salePrice: 30,
        sku: 'JJGHI61AA',
        categoryId: '1',
        productAttributes: [
          ProductAttributeModel(name: 'Color', values: ['Green', 'Black', 'White']),
          ProductAttributeModel(name: 'Size', values: ['EU 30', 'EU 32', 'EU 34']),
        ],
        productVariations: [
          ProductVariationModel(
              id: '1',
              stock: 34,
              price: 134,
              salePrice: 122.6,
              image: EImages.productImage1,
              description: 'This is a product description for Nike air shoes.',
              attributeVales: {'Color': 'Green', 'Size': 'EU 34'}),
          ProductVariationModel(
              id: '2',
              stock: 15,
              price: 132,
              image: EImages.productImage3,
              attributeVales: {'Color': 'Black', 'Size': 'EU 32'}),
          ProductVariationModel(
              id: '3',
              stock: 0,
              price: 234,
              image: EImages.productImage3,
              attributeVales: {'Color': 'Green', 'Size': 'EU 36'}),
          ProductVariationModel(
              id: '4',
              stock: 222,
              price: 232,
              image: EImages.productImage1,
              attributeVales: {'Color': 'Purple', 'Size': 'EU 32'}),
          ProductVariationModel(
              id: '5',
              stock: 0,
              price: 334,
              image: EImages.productImage2,
              attributeVales: {'Color': 'White', 'Size': 'EU 34'}),
          ProductVariationModel(
              id: '6',
              stock: 11,
              price: 332,
              image: EImages.productImage1,
              attributeVales: {'Color': 'Blue', 'Size': 'EU 32'}),
        ],
        productType: 'ProductType.variable',
    ),
  ];

}