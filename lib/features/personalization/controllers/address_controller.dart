import 'package:e_com_app/common/widgets/loaders/animation_loader.dart';
import 'package:e_com_app/common/widgets/loaders/loaders.dart';
import 'package:e_com_app/common/widgets/loaders/network_manager.dart';
import 'package:e_com_app/common/widgets/texts/section_heading.dart';
import 'package:e_com_app/data/repositories/address/address_repository.dart';
import 'package:e_com_app/features/personalization/screens/address/add_new_address.dart';
import 'package:e_com_app/features/personalization/screens/address/widget/single_address.dart';
import 'package:e_com_app/features/shop/models/address_model.dart';
import 'package:e_com_app/util/constants/image_strings.dart';
import 'package:e_com_app/util/constants/sizes.dart';
import 'package:e_com_app/util/helpers/cloud_helper_functions.dart';
import 'package:e_com_app/util/popups/EFullScreenLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  RxBool refreshData = true.obs;
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  final addressRepository = Get.put(AddressRepository());

  ///--fetch all addresses user
  Future<List<AddressModel>> getAllUserAddresses() async {
    try {
      final addresses = await addressRepository.fetchUserAddresses();
      // Automatically select the first address or a pre-selected one
      selectedAddress.value = addresses.firstWhere(
            (address) => address.selectedAddress,
        orElse: () => AddressModel.empty(),
      );
      return addresses;
    } catch (e) {
      ELoaders.errorSnackBar(
        title: 'Address not found',
        message: e.toString(),
      );
      return [];
    }
  }

  Future selectAddress(AddressModel newSelectedAddress) async {
    try {
      // Display a loading dialog
      Get.defaultDialog(
        title: '',
        barrierDismissible: false,
        content: const CircularProgressIndicator(),
      );

      if (selectedAddress.value.id.isNotEmpty) {
        // Unselect the previously selected address
        await addressRepository.updateSelectedField(selectedAddress.value.id, false);
      }

      // Set the new address as selected
      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;
      await addressRepository.updateSelectedField(newSelectedAddress.id, true);

      // Close the dialog
      Get.back();
    } catch (e) {
      Get.back();
      ELoaders.errorSnackBar(
        title: 'Error in selection',
        message: e.toString(),
      );
    }
  }


  ///--add new addresses
  Future addNewAddresses() async {
    try {
      EFullScreenLoader.openLoadingDialog('Storing Address...', EImages.docer);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        EFullScreenLoader.stopLoading();
        return;
      }

      if (!addressFormKey.currentState!.validate()) {
        EFullScreenLoader.stopLoading();
        return;
      }

      final address = AddressModel(
        id: '',
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        street: street.text.trim(),
        city: city.text.trim(),
        state: state.text.trim(),
        postalCode: postalCode.text.trim(),
        country: country.text.trim(),
        selectedAddress: true,
      );
      final id = await addressRepository.addAddress(address);

      address.id = id;
      await selectAddress(address);
      
      EFullScreenLoader.stopLoading();
      
      ELoaders.successSnackBar(title: 'Congratulations', message: 'Your address has been saved successfully.');

      refreshData.toggle();

      resetFormField();

      Navigator.of(Get.context!).pop();
    } catch (e) {
      EFullScreenLoader.stopLoading();
      ELoaders.errorSnackBar(title: 'Address not found', message: e.toString());
    }
  }

  Future<dynamic> selectNewAddressPopup(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (_) => Container(
          padding: const EdgeInsets.all(ESizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ESectionHeading(title: 'Select Address', showActionButton: false),
              FutureBuilder(
                  future: getAllUserAddresses(),
                  builder: (_, snapshot) {
                    final response = ECloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
                    if (response != null) return response;

                    return ListView.builder(
                      shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) => ESingleAddress(
                            address: snapshot.data![index],
                            onTap: () async {
                              await selectAddress(snapshot.data![index]);
                              Get.back();
                            }
                        ),
                    );
                  }
              ),
              const SizedBox(height: ESizes.defaultSpace * 2),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: () => Get.to(() => const AddNewAddressScreen()), child: const Text('Add new Address')),
              ),
            ],
          ),
        )
    );
  }

  ///--function to reset from field
  void resetFormField() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    state.clear();
    country.clear();
    addressFormKey.currentState?.reset();
  }
}

