import 'package:flutter/material.dart';
import 'package:wt_firepod_tree_view/wt_riverpod_tree_view.dart';
import 'package:wt_firepod_tree_view_examples/models/customer.dart';
import 'package:wt_firepod_tree_view_examples/models/delivery.dart';
import 'package:wt_firepod_tree_view_examples/models/driver.dart';
import 'package:wt_firepod_tree_view_examples/models/supplier.dart';

void main() {
  runApp(MaterialApp(
    title: 'Simple Animated Tree Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: const TestFirepodTreeView(),
  ));
}

class TestFirepodTreeView extends StatelessWidget {
  const TestFirepodTreeView({super.key});

  static final customer = Customer(
    id: '001',
    name: 'Customer 1',
    phone: '040400001',
    email: 'customer+1@example.com',
    address: '1 main street, Pakenham',
    postcode: 3810,
  );

  static final supplier = Supplier(id: '001', name: 'Supplier 1', code: 'SUP1');
  static final driver =
      Driver(id: '001', name: 'Driver 1', phone: '0404111111');
  static final delivery = Delivery(
    customer: customer,
    supplier: supplier,
    driver: driver,
  );

  static final dataMap1 = {
    'a': 'A',
    'b': 'B',
    'c': {
      'cc': 'C',
      'dd': 'D',
      'ee': 'E',
      'ff': 'F',
    },
  };

  static final dataList2 = ['AAA', dataMap1, 'CCC'];

  static final dataMap2 = {
    'a': 'AA',
    'b': 'BB',
    'c': {
      'cc': 'CC',
      'dd': 'DD',
      'ee': dataList2,
      'ff': 'FF',
    },
  };

  static final dataList1 = ['First', dataMap2, 'Last', delivery];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Animated Tree Demo'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: FirepodTreeView.fromList(dataList1),
          ),
          Expanded(
            child: FirepodTreeView.fromMap(dataMap2),
          ),
        ],
      ),
    );
  }
}
