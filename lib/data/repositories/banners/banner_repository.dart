
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_com_app/features/shop/models/banner_model.dart';
import 'package:e_com_app/util/exceptions/firebase_exceptions.dart';
import 'package:e_com_app/util/exceptions/format_excptions.dart';
import 'package:e_com_app/util/exceptions/platform_exceptions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  ///--get all order related to current user
  Future<List<BannerModel>> fetchBanner() async {
    try {
      final result = await _db.collection('Banners').where('Active', isEqualTo: true).get();
      return result.docs.map((documentSnapshot) => BannerModel.fromSnapshot(documentSnapshot)).toList();
    } on FirebaseException catch (e) {
      throw EFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const EFormatException();
    } on PlatformException catch (e) {
      throw EPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while fetching Banners.';
    }
  }
}