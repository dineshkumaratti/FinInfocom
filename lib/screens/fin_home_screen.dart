// ignore_for_file: sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static List<String> sortList = [
    'Sort By name',
    'Sort By age',
    'Sort By city'
  ];
  String sortvalue = sortList[0];
  String sortName = 'name';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('FinDetails')
                      .orderBy(
                        sortName,
                        descending: false,
                      )
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.size <= 0) {
                        return const Center(
                          child: Text('Nothing found'),
                        );
                      }
                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                DropdownButton(
                                  value: sortvalue,
                                  underline: Container(
                                    height: 20,
                                    width: 50,
                                  ),
                                  hint: const Text('Sort By'),
                                  items: sortList.map((items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items.toString()),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    String? dropdownval;
                                    if (value == sortList[0]) {
                                      dropdownval = 'name';
                                    } else if (value == sortList[1]) {
                                      dropdownval = 'age';
                                    } else {
                                      dropdownval = 'city';
                                    }
                                    setState(() {
                                      sortvalue = value!;
                                      sortName = dropdownval!;
                                    });
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ListView.builder(
                              scrollDirection: Axis.vertical,
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.size,
                              itemBuilder: (context, index) {
                                var json = snapshot.data!.docs[index].data()
                                    as Map<String, dynamic>;
                                return ListTile(
                                  title: Column(
                                    children: [
                                      Text('Name:${json['name']}'),
                                      Text('Age:${json['age'].toString()}'),
                                      Text('City:${json['city']}'),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return const Text('Unable to connect');
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
