import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class FirebaseFetch {


 static Future<List<Map<String, dynamic>>> fetchInvoiceData(String invoiceId) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Create a list to hold the fetched data
      List<Map<String, dynamic>> invoiceDataList = [];

      // Fetch the main invoice document
      DocumentSnapshot invoiceSnapshot = await firestore.collection('Invoices').doc(invoiceId).get();

      if (!invoiceSnapshot.exists) {
        throw Exception('Invoice not found');
      }

      // Fetch invoice data
      Map<String, dynamic> invoiceData = invoiceSnapshot.data() as Map<String, dynamic>;
      invoiceDataList.add({
        'invoiceId': invoiceId,
        'status': invoiceData['status'] ?? 'Unknown',
        'subtotal': invoiceData['subtotal'] ?? 0.0,
        'date': invoiceData['date'] ?? 'N/A',
        'client': invoiceData['client'] ?? 'Unknown Client',
        'billingStreet': invoiceData['billingStreet'] ?? 'Unknown Address',
        'currency': invoiceData['currency'] ?? 'USD',
        'clientNote': invoiceData['clientNote'] ?? 'No note',
        'terms': invoiceData['terms'] ?? 'No terms',
      });

      // Fetch payment details subcollection
      DocumentSnapshot paymentDetailsSnapshot = await firestore
          .collection('Invoices')
          .doc(invoiceId)
          .collection('details')
          .doc('paymentdetails')
          .get();

      if (paymentDetailsSnapshot.exists) {
        Map<String, dynamic> paymentDetails = paymentDetailsSnapshot.data() as Map<String, dynamic>;
        invoiceDataList.add({
          'totalAmount': paymentDetails['totalAmount'] ?? 0.0,
          'invoiceDate': paymentDetails['invoiceDate'] ?? 'N/A',
          'paymentMode': paymentDetails['paymentMode'] ?? 'Not Specified',
          'dueDate': paymentDetails['dueDate'] ?? 'N/A',
        });
      }

      // Fetch ordered items subcollection
      DocumentSnapshot orderedItemsSnapshot = await firestore
          .collection('Invoices')
          .doc(invoiceId)
          .collection('details')
          .doc('ordereditems')
          .get();

      if (orderedItemsSnapshot.exists) {
        Map<String, dynamic> orderedItems = orderedItemsSnapshot.data() as Map<String, dynamic>;
        invoiceDataList.add({
          'itemName': orderedItems['itemName'] ?? 'Unknown Item',
          'itemId': orderedItems['itemId'] ?? 'Unknown ID',
          'quantity': orderedItems['quantity'] ?? '0',
          "rate" : orderedItems["rate"] ?? 0,
        });
      }

      // Return the list of data
      return invoiceDataList;
    } catch (e) {
      print('Error fetching invoice data: $e');
      return []; // Return an empty list on error
    }
  }


  static Future<Map<String, dynamic>?> fetchCustomerData(String customerId) async {
    try {
      // Reference to the customer document
      DocumentReference customerRef = FirebaseFirestore.instance.collection('Customers').doc(customerId);

      // Fetch the main customer document
      DocumentSnapshot customerSnapshot = await customerRef.get();

      if (!customerSnapshot.exists) {
        log('Customer not found');
        return null;
      }

      // Fetch subcollection documents
      DocumentSnapshot billingSnapshot = await customerRef.collection('customerDetails').doc('billing').get();
      DocumentSnapshot profileSnapshot = await customerRef.collection('customerDetails').doc('profile').get();

      // Combine data
      Map<String, dynamic> customerData = {
        'main': customerSnapshot.data(),
        'billing': billingSnapshot.exists ? billingSnapshot.data() : {},
        'profile': profileSnapshot.exists ? profileSnapshot.data() : {},
      };

      return customerData;
    } catch (e) {
      print('Error fetching customer data: $e');
      return null;
    }
  }


  static Future<List<Map<String, dynamic>>> fetchDetails({
    required String collectionName,
    bool fetchSubcollection = false,
    String? subcollectionName,
  }) async {
    List<Map<String, dynamic>> documentsList = [];

    try {
      // Fetch the main collection documents
      QuerySnapshot mainCollectionSnapshot =
      await FirebaseFirestore.instance.collection(collectionName).get();

      for (var doc in mainCollectionSnapshot.docs) {
        Map<String, dynamic> docData = doc.data() as Map<String, dynamic>;
        documentsList.add({
          'id': doc.id,
          ...docData,
        });

        // Check if subcollection needs to be fetched
        if (fetchSubcollection && subcollectionName != null) {
          QuerySnapshot subcollectionSnapshot = await FirebaseFirestore.instance
              .collection(collectionName)
              .doc(doc.id)
              .collection(subcollectionName)
              .get();

          for (var subDoc in subcollectionSnapshot.docs) {
            Map<String, dynamic> subDocData = subDoc.data() as Map<String, dynamic>;
            documentsList.add({
              'id': subDoc.id,
              ...subDocData,
            });
          }
        }
      }
    } catch (e) {
      log('Error fetching details: $e');
    }

    return documentsList;
  }







}