import 'package:flutex_admin/core/utils/dimensions.dart';
import 'package:flutex_admin/core/utils/local_strings.dart';
import 'package:flutex_admin/data/model/customer/customer_details.dart';
import 'package:flutex_admin/view/components/divider/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerBilling extends StatelessWidget {
  const CustomerBilling({
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
                    Text(LocalStrings.billingAddress.tr),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(customerModel["profile"]["address"] ?? '-'),
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
                    Text(customerModel["billing"]["billingCity"] ?? '-'),
                    Text(customerModel["billing"]["billingState"] ?? '-'),
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
                    Text(customerModel["billing"]["billingZip"] ?? '-'),
                    Text(customerModel["billing"]["billingCountry"] ?? '-'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
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
                        Text(LocalStrings.shippingAddress.tr),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(customerModel["profile"]["shippingStreet"] ?? '-'),
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
                    Text(customerModel["profile"]["shippingCity"] ?? '-'),
                    Text(customerModel["profile"]["shippingState"]?? '-'),
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
                    Text(customerModel["profile"]["shippingZip"] ?? '-'),
                    Text(customerModel["profile"]["shippingCountry"] ?? '-'),
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
