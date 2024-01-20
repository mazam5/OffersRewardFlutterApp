import 'dart:convert';

import 'package:azam_shoshin_task/model/model_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ScreenMain extends StatelessWidget {
  const ScreenMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: const Text('Shoshin App'),
              ),
              ListTile(
                title: const Text('Home'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                title: const Text('Profile'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                title: const Text('Settings'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                title: const Text('Logout'),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          iconTheme: const IconThemeData(color: Colors.white),
          toolbarHeight: 80,
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.notes),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          title: const Text(
            'Hey Shoshin',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
              ),
              child: InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Icon(
                        MdiIcons.walletOutline,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      '₹ 452',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        body: const BottomApp());
  }
}

class BottomApp extends StatefulWidget {
  const BottomApp({super.key});

  @override
  State<BottomApp> createState() => _BottomApp();
}

class _BottomApp extends State<BottomApp> with SingleTickerProviderStateMixin {
  late List _data = [];
  late AnimationController _controller;
  late Animation<double> _animation;
  Future<List<Model1>> _readJson() async {
    final String response =
        await rootBundle.loadString('assets/dummy_tasks.json');
    final data = await json.decode(response);
    setState(() {
      _data = data;
    });
    final List<Model1> tasks = [];
    for (var i = 0; i < data.length; i++) {
      tasks.add(Model1.fromJson(data[i]));
    }
    return tasks;
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 0.3),
        weight: 1.0,
      ),
    ]).animate(_controller);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });

    _readJson();
    _startAnimation();
  }

  void _startAnimation() {
    _controller.forward(from: 0.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: Colors.white,
          bottom: TabBar(
            indicatorWeight: 5,
            indicatorColor: Theme.of(context).primaryColor,
            labelColor: Theme.of(context).primaryColor,
            tabs: [
              Tab(
                icon: Icon(Icons.category_rounded,
                    color: Theme.of(context).primaryColor),
                child: const Text(
                  'All Offers',
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.card_giftcard,
                  color: Colors.red[300],
                ),
                child: const Text(
                  'Gifts',
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
              const Tab(
                icon: Icon(Icons.schedule, color: Colors.amber),
                child: Text(
                  'Upcoming',
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
              const Tab(
                icon:
                    Icon(Icons.check_circle_outline, color: Colors.deepPurple),
                child: Text(
                  'My Offers',
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(300 * _animation.value, 0.0),
                          child: Row(
                            children: [
                              const Text(
                                'Rajesh earned ',
                              ),
                              Text(
                                '₹ 120',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(' from BookMyShow Offer'),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    Row(children: [
                      Icon(MdiIcons.fire, color: Colors.amber),
                      const Text('Trending offers'),
                    ]),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 200,
                      child: FutureBuilder(
                          future: _readJson(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  itemCount: _data.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    int number =
                                        int.parse(_data[index]['total_lead']);
                                    String formattedNumber =
                                        NumberFormat.compact().format(number);
                                    return Card(
                                      child: Stack(
                                        children: [
                                          InkWell(
                                            onTap: () => Navigator.pushNamed(
                                              context,
                                              '/screen_2',
                                            ),
                                            splashColor: Theme.of(context)
                                                .primaryColor
                                                .withOpacity(0.5),
                                            child: Image.network(
                                              _data[index]['brand']['logo'],
                                              fit: BoxFit.contain,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.3,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  3.5,
                                            ),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.8),
                                                ),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.3,
                                                height: 80,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        _data[index]['brand']
                                                            ['title'],
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Get Rs. ${_data[index]['payout_amt']}',
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                      Row(children: [
                                                        Icon(
                                                          MdiIcons
                                                              .lightningBolt,
                                                          color: const Color
                                                              .fromARGB(255,
                                                              233, 159, 62),
                                                          size: 16,
                                                        ),
                                                        Text(
                                                          formattedNumber,
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    233,
                                                                    159,
                                                                    62),
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ]),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            } else if (snapshot.hasError) {
                              return const Text('Error');
                            } else {
                              return const CircularProgressIndicator();
                            }
                          }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(Icons.apps, color: Theme.of(context).primaryColor),
                        const Text('More offers'),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: _data.length,
                      itemBuilder: (context, index) {
                        var color =
                            _data[index]['custom_data']['dominant_color'];
                        Color hexToColor(String hexColor) {
                          hexColor = hexColor.replaceAll("#", "");
                          int hexValue = int.parse(hexColor, radix: 16);
                          return Color(hexValue | 0xFF000000);
                        }

                        int number = int.parse(_data[index]['total_lead']);
                        String formattedNumber =
                            NumberFormat.compact().format(number);
                        return Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: hexToColor(color),
                              width: 2,
                            ),
                          ),
                          child: ListTile(
                            leading: Image.network(
                              _data[index]['thumbnail'],
                              fit: BoxFit.contain,
                              width: 100,
                              height: 100,
                            ),
                            title: Text(
                              _data[index]['brand']['title'],
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                OutlinedButton(
                                  style: ButtonStyle(
                                    side: MaterialStateProperty.all<BorderSide>(
                                      BorderSide(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                  ),
                                  onPressed: () =>
                                      Navigator.pushNamed(context, '/screen_2'),
                                  child: Text(
                                    'Get ${_data[index]['payout']}',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      MdiIcons.lightningBolt,
                                      color: const Color.fromARGB(
                                          255, 233, 159, 62),
                                      size: 16,
                                    ),
                                    Text(
                                      formattedNumber,
                                      style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 233, 159, 62),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const Center(
              child: Text('Gifts'),
            ),
            const Center(
              child: Text('Upcoming'),
            ),
            const Center(
              child: Text('My Offers'),
            ),
          ],
        ),
      ),
    );
  }
}
