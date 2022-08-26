import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:valorant_app/product/card_agent.dart';
import 'package:valorant_app/product/card_map.dart';
import 'package:valorant_app/product/top_section.dart';

import '../models/agent_data.dart';
import '../models/map_data.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final url = Uri.parse('https://valorant-api.com/v1/agents');
  final mapUrl = Uri.parse('https://valorant-api.com/v1/maps');
  var agentResult;
  var mapResult;

  Future callMap() async {
    final mapResponse = await http.get(mapUrl);
    final response = await http.get(url);
    if (mapResponse.statusCode == 200) {
      final mapNetworkresult = MapData.fromJson(json.decode(mapResponse.body));
      final result = Agent.fromJson(json.decode(response.body));
      if (mounted) {
        setState(() {
          mapResult = mapNetworkresult;
          agentResult = result;
        });
      }
    } else {
      throw Exception('Failed to load post');
    }
  }

  @override
  void initState() {
    super.initState();
    callMap();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          extendBody: true,
          appBar: AppBar(
            title: Container(
              height: 40,
              child: Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fc/Valorant_logo_-_pink_color_version.svg/2560px-Valorant_logo_-_pink_color_version.svg.png'),
            ),
            actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.supervised_user_circle_outlined))],
          ),
          bottomNavigationBar: const BottomAppBar(
            notchMargin: 5,
            shape: CircularNotchedRectangle(),
            child: TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  icon: Icon(Icons.home),
                  child: Text('Home', style: TextStyle(fontSize: 12)),
                ),
                Tab(
                  icon: Icon(Icons.map_outlined),
                  child: Text('Maps', style: TextStyle(fontSize: 12)),
                ),
                Tab(
                  icon: Icon(Icons.list_outlined),
                  child: Text('Agents', style: TextStyle(fontSize: 12)),
                ),
                Tab(
                  icon: Icon(Icons.location_searching_outlined),
                  child: Text('Weapons', style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            backgroundColor: Colors.red,
            onPressed: () {
              print('pressed');
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'LINE UPS',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          drawer: const Drawer(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: mapResult == null
                ? Center(
                    child: Container(
                      height: 40.0,
                      width: 40.0,
                      child: const CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      ),
                    ),
                  )
                : ListView(
                    children: [
                      const TopSection(),
                      SizedBox(
                        height: 240,
                        child: mapList(),
                      ),
                      SizedBox(
                        height: 205,
                        child: agentList(),
                      ),
                    ],
                  ),
          )),
    );
  }

  ListView agentList() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: agentResult?.data?.length ?? 0,
      itemBuilder: (context, index) {
        if (agentResult.data[index].isPlayableCharacter != true) {
          return Container();
        }
        return AgentCard(
            imageUrl: agentResult.data[index].displayIcon, name: (agentResult.data[index].displayName).toString());
      },
    );
  }

  ListView mapList() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: mapResult?.data?.length ?? 0,
      itemBuilder: (context, index) {
        if ((mapResult.data[index].displayName).toString() == 'The Range') {
          return Container();
        }
        return MapCard(imageUrl: mapResult.data[index].splash, name: (mapResult.data[index].displayName).toString());
      },
    );
  }
}
