import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int points = 0;
  var json;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    final url = Uri.parse('http://pt/frantic.in/RestApi/fetch_shops_by_distance');

    http.Response response = await http.post(url, body: {
      "latitude": "28.6210",
      "longitude": "77.3812",
      "distance": "20",
    });
    json = jsonDecode(response.body);
    print(json);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          buildAppBar(),
          Expanded(
            child: SizedBox(
              height: 600,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Your Rewards',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'See all',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        height: 35,
                        width: 150,
                        decoration: const BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.all(
                            Radius.circular(40),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.card_giftcard,
                              color: Colors.white,
                              size: 20,
                            ),
                            Text(
                              '  Your Points: ${points.toString()}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 180,
                        width: double.maxFinite,
                        child: ListView.builder(
                          // shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return GeneralCard(
                              shopName: json['data'][index]['shops'][index]['shop_name'] ?? '',
                              shopDescription: json['data']['shops'][index]['categories'][0]['category_type'] ?? ' ',
                              shopCity: json['data']['shops'][index]['shop']['city'] ?? '',
                              shopOpenStatus: json['data']['shops'][index]['ratings'] ?? '',
                            );
                          },
                        ),
                      ),
                      const BoldText(
                        title: 'Categories',
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 2.0,
                              spreadRadius: 0.0,
                              offset: Offset(2.0, 2.0),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.local_fire_department,
                          size: 30,
                          color: Colors.yellow[600],
                        ),
                      ),
                      const Text(
                        'Mobile',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const HorizontalScrollableSection(
                        sectionTitle: 'Best shops in the ATTA MARKET',
                      ),
                      const HorizontalScrollableSection(
                        sectionTitle: 'Best shops in GIP',
                      ),
                      const HorizontalScrollableSection(
                        sectionTitle: 'Best shops in the Rajpur MARKET',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container buildAppBar() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10.0,
            spreadRadius: 0.0,
            offset: Offset(10.0, 0.0),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.qr_code_scanner,
                  color: Colors.purple,
                ),
                onPressed: () {},
              ),
              const CircleAvatar(
                radius: 25,
                backgroundColor: Colors.purple,
                child: Icon(
                  Icons.shopping_basket,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.shopping_bag,
                        color: Colors.purple,
                      )),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.power_settings_new,
                      color: Colors.purple,
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(
                Icons.location_on,
                color: Colors.purple,
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Home',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black54),
                    ),
                    Text(
                      'Howrah Bridge Kolkata, Block 32, Lane 45, street 409, Pin 700012,Near railway station bridge, Right on top of the river',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class GeneralCard extends StatelessWidget {
  final String imageUrl;
  final String shopName;
  final String shopDescription;
  final String shopCity;
  final String shopOpenStatus;
  const GeneralCard({
    Key? key,
    this.imageUrl = '',
    required this.shopName,
    required this.shopDescription,
    required this.shopCity,
    required this.shopOpenStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        width: 300,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Stack(
                children: [
                  Image.asset(
                    imageUrl,
                    fit: BoxFit.contain,
                  ),
                  const Positioned(
                    right: 15,
                    bottom: 15,
                    child: HighlightingContainer(
                      iconPresent: true,
                      color: Colors.green,
                      textValue: '4.5',
                    ),
                  ),
                  const Positioned(
                    right: 15,
                    top: 15,
                    child: HighlightingContainer(
                      iconPresent: false,
                      color: Colors.yellow,
                      textValue: '0 Offer',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  BoldText(title: shopName),
                  Text(shopDescription),
                  Text(shopCity),
                  Container(
                    height: 25,
                    width: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.purple),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(6),
                      ),
                    ),
                    child: Text(shopOpenStatus),
                  )
                ],
              ),
            )
          ],
        ));
  }
}

class HighlightingContainer extends StatelessWidget {
  final Color color;
  final bool iconPresent;
  final String textValue;
  const HighlightingContainer({
    required this.color,
    required this.iconPresent,
    required this.textValue,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 50,
      color: color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iconPresent ? const Icon(Icons.star, color: Colors.white) : const SizedBox(),
          Text(
            textValue,
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}

class HorizontalScrollableSection extends StatelessWidget {
  final String sectionTitle;
  const HorizontalScrollableSection({
    required this.sectionTitle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              sectionTitle,
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'See all',
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 180,
          width: double.maxFinite,
          child: ListView.builder(
            // shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Container(
                height: 150,
                width: 300,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                child: const Placeholder(
                  color: Colors.green,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class BoldText extends StatelessWidget {
  final String title;
  const BoldText({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    );
  }
}
