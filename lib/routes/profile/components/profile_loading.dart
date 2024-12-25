import 'package:flutter/material.dart';
import 'package:okuur/ui/components/shimmer_box.dart';

Widget profileLoadingBox() {
  return const Column(
    children: [
      SizedBox(height: 12),
      Row(
        children: [
          ShimmerBox(
            width: 82,
            height: 82,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              children: [
                ShimmerBox(
                  height: 10,
                ),
                SizedBox(height: 12),
                ShimmerBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
      SizedBox(height: 12),
      ShimmerBox(height: 28),
      SizedBox(height: 12,),
      Row(
        children: [
          ShimmerBox(
            width: 98,
            height: 58,
          ),
          SizedBox(width: 12),
          ShimmerBox(
            width: 98,
            height: 58,
          ),
        ],
      ),
      SizedBox(height: 12),
      ShimmerBox(
        height: 112,
        borderRadius: BorderRadius.all(Radius.circular(14)),
      ),
      SizedBox(height: 12),
      ShimmerBox(
        height: 112,
        borderRadius: BorderRadius.all(Radius.circular(14)),
      ),
      SizedBox(height: 64,)
    ],
  );
}