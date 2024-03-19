import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingBarApp extends StatefulWidget {
  const RatingBarApp({
    Key? key,
    required this.ratingScore,
    required this.onRatingChanged,
  }) : super(key: key);

  final double ratingScore;
  final Function(double) onRatingChanged;

  @override
  State<RatingBarApp> createState() => RatingBarState();
}

class RatingBarState extends State<RatingBarApp> {
  @override
  Widget build(BuildContext context) {
    double _ratingScore = widget.ratingScore;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: RatingBar.builder(
        updateOnDrag: true,
        initialRating: widget.ratingScore.toDouble(),
        minRating: 0,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemSize: 30,
        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
        itemBuilder: (context, _) => const Icon(
          Icons.star,
          color: Colors.amber,
        ),
        onRatingUpdate: (double rating) {
          setState(() {
            _ratingScore = rating;
            debugPrint('Rating: $_ratingScore');
            widget.onRatingChanged(_ratingScore);
          });
        },
      ),
    );
  }
}
