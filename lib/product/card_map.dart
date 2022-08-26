import 'package:flutter/material.dart';

class MapCard extends StatelessWidget {
  const MapCard({Key? key, required this.imageUrl, required this.name}) : super(key: key);
  final String imageUrl;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () {},
        child: SizedBox(
            width: 320,
            child: Column(children: [
              Image.network(imageUrl, fit: BoxFit.fitHeight),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  name,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              )
            ])),
      ),
    );
  }
}
