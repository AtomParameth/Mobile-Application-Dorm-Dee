import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingBarApp extends StatefulWidget {
  const RatingBarApp({Key? key, required this.rating, required this.itemSize})
      : super(key: key);

  final int rating;
  final int itemSize;
  @override
  State<RatingBarApp> createState() => RatingBarState();
}

class RatingBarState extends State<RatingBarApp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: RatingBar.builder(
        initialRating: widget.rating.toDouble(),
        minRating: 0,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemSize: widget.itemSize.toDouble(),
        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
        itemBuilder: (context, _) => const Icon(
          Icons.star,
          color: Colors.amber,
        ),
        onRatingUpdate: (rating) {
          print(rating);
        },
      ),
    );
  }
}
