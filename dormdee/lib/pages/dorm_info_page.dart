import 'package:flutter/material.dart';
import 'package:dormdee/models/dorm_model.dart';

class DormInfoPage extends StatefulWidget {
  const DormInfoPage({Key? key, required this.dorm}) : super(key: key);

  final DormModel dorm;

  @override
  State<DormInfoPage> createState() => _DormInfoPageState();
}

class _DormInfoPageState extends State<DormInfoPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(widget.dorm.name),
      ),
      body: Column(
        children: [
          Image.network(widget.dorm.imageUrl),
          Text(widget.dorm.name),
          Text(widget.dorm.address),
          Text(widget.dorm.information),
          Text(widget.dorm.price),
          Text(widget.dorm.rating.toString()),
          Text(widget.dorm.category),
          Text(widget.dorm.contact),
        ],
      ),
    ));
  }
}
