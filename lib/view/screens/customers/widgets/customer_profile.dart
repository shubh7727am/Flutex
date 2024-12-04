import 'package:flutex_admin/core/utils/dimensions.dart';
import 'package:flutex_admin/core/utils/local_strings.dart';
import 'package:flutex_admin/data/model/customer/customer_details.dart';
import 'package:flutex_admin/view/components/divider/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerProfile extends StatelessWidget {
  const CustomerProfile({
    super.key,
    required this.customerModel,
  });
  final Map<String,dynamic> customerModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.space10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(Dimensions.space15),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(Dimensions.cardRadius),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(LocalStrings.company.tr),
                    Text(LocalStrings.vatNumber.tr),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(customerModel["main"]["name"] ?? ''),
                    Text(customerModel["profile"]["vat"] ?? '-'),
                  ],
                ),
                const CustomDivider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(LocalStrings.phone.tr),
                    Text(LocalStrings.website.tr),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(customerModel["main"]["contact"] ?? ''),
                    Text(customerModel["profile"]["website"] ?? '-'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: Dimensions.space20),
          Container(
            padding: const EdgeInsets.all(Dimensions.space15),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(Dimensions.cardRadius),
              ),
            ),
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(LocalStrings.address.tr),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(customerModel["profile"]["address"] ?? '-'),
                      ],
                    ),
                  ],
                ),
                const CustomDivider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(LocalStrings.city.tr),
                    Text(LocalStrings.state.tr),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(customerModel["profile"]["city"] ?? '-'),
                    Text(customerModel["profile"]["state"] ?? '-'),
                  ],
                ),
                const CustomDivider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(LocalStrings.zipCode.tr),
                    Text(LocalStrings.country.tr),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(customerModel["profile"]["zip"] ?? '-'),
                    Text(customerModel["profile"]["country"] ?? '-'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
